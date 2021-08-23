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
    
    private lazy var compatibilityManager = CompatibilityManagerCore()
}

// MARK: Public
extension CompatibilitySignsViewModel {
    func store(signs: CompatibilitySigns) -> Completable {
        compatibilityManager
            .store(selected: signs)
            .asCompletable()
    }
}

// MARK: Private
private extension CompatibilitySignsViewModel {
    func makeInitialSigns() -> Driver<CompatibilitySigns?> {
        compatibilityManager
            .getSelectedSigns()
            .asDriver(onErrorJustReturn: nil)
    }
}
