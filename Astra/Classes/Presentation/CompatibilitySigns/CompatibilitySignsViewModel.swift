//
//  CompatibilitySignsViewModel.swift
//  Astra
//
//  Created by Andrey Chernyshev on 22.08.2021.
//

import RxSwift
import RxCocoa

final class CompatibilitySignsViewModel {
    lazy var initialSigns = makeInitialSigns()
    
    lazy var store = PublishRelay<CompatibilitySigns>()
    
    private lazy var compatibilityManager = CompatibilityManagerCore()
}

// MARK: Private
private extension CompatibilitySignsViewModel {
    func makeInitialSigns() -> Driver<CompatibilitySigns?> {
        let signs = compatibilityManager
            .getSelectedSigns()
            .asDriver(onErrorJustReturn: nil)
        
        let store = makeStore()
        
        return Driver.merge(
            signs, store
        )
    }
    
    func makeStore() -> Driver<CompatibilitySigns?> {
        store
            .flatMapLatest { [weak self] signs -> Single<CompatibilitySigns?> in
                guard let self = self else {
                    return .never()
                }
                
                return self.compatibilityManager
                    .store(selected: signs)
                    .flatMap { .never() }
            }
            .asDriver(onErrorDriveWith: .never())
    }
}
