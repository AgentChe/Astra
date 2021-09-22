//
//  PaygateViewModel.swift
//  Astra
//
//  Created by Andrey Chernyshev on 08.09.2021.
//

import RxSwift
import RxCocoa

final class PaygateViewModel {
    enum Step {
        case buyed, restored, error, canceled
    }
    
    let buy = PublishRelay<String>()
    let restore = PublishRelay<Void>()
    
    lazy var paygate = makePaygate()
    lazy var paygate2 = makePaygate2()
    lazy var step = Driver.merge(makeBuyed(), makeRestored())
    lazy var activityIndicator = RxActivityIndicator()
    
    private lazy var paygateManager = PaygateManagerCore()
    private lazy var purchaseInteractor = SDKStorage.shared.purchaseInteractor
}

// MARK: Private
private extension PaygateViewModel {
    func makePaygate() -> Driver<Paygate> {
        return paygateManager.obtainSource()
            .flatMap { [weak self] source -> Single<Paygate?> in
                guard let self = self, let source = source else {
                    return .never()
                }
                
                return self.paygateManager
                    .preparePrices(for: source)
                    .trackActivity(self.activityIndicator)
                    .asSingle()
            }
            .compactMap { $0 }
            .asDriver(onErrorDriveWith: .empty())
    }
    
    func makePaygate2() -> Driver<Paygate2> {
        return paygateManager.obtainSource2()
            .flatMap { [weak self] source -> Single<Paygate2?> in
                guard let self = self, let source = source else {
                    return .never()
                }
                
                return self.paygateManager
                    .preparePrices2(for: source)
                    .trackActivity(self.activityIndicator)
                    .asSingle()
            }
            .compactMap { $0 }
            .asDriver(onErrorDriveWith: .empty())
    }
    
    func makeBuyed() -> Driver<Step> {
        buy
            .flatMapLatest { [weak self] productId -> Observable<Step> in
                guard let self = self else {
                    return .never()
                }
                
                return self.purchaseInteractor
                    .makeActiveSubscriptionByBuy(productId: productId)
                    .map { result -> Step in
                        switch result {
                        case .completed(let response):
                            return response != nil ? .buyed : .error
                        case .cancelled:
                            return .canceled
                        }
                    }
                    .trackActivity(self.activityIndicator)
                    .catchAndReturn(.error)
            }
            .asDriver(onErrorJustReturn: .error)
    }
    
    func makeRestored() -> Driver<Step> {
        restore
            .flatMapLatest { [weak self] _ -> Observable<Step> in
                guard let self = self else {
                    return .never()
                }
                
                return self.purchaseInteractor
                    .makeActiveSubscriptionByRestore()
                    .map { result -> Step in
                        switch result {
                        case .completed(let response):
                            return response != nil ? .restored : .error
                        case .cancelled:
                            return .canceled
                        }
                    }
                    .trackActivity(self.activityIndicator)
                    .catchAndReturn(.error)
            }
            .asDriver(onErrorJustReturn: .error)
    }
}
