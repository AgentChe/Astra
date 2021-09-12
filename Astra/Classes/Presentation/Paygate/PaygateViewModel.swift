//
//  PaygateViewModel.swift
//  Astra
//
//  Created by Andrey Chernyshev on 08.09.2021.
//

import RxSwift
import RxCocoa

final class PaygateViewModel {
    lazy var paygate = makePaygate()
    
    private lazy var paygateManager = PaygateManagerCore()
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
            }
            .compactMap { $0 }
            .asDriver(onErrorDriveWith: .empty())
    }
}
