//
//  CompatibilityViewModel.swift
//  Astra
//
//  Created by Andrey Chernyshev on 23.08.2021.
//

import RxSwift
import RxCocoa

final class CompatibilityViewModel {
    lazy var elements = makeElements()
    
    private lazy var compatibilityManager = CompatibilityManagerCore()
}

// MARK: Private
private extension CompatibilityViewModel {
    func makeElements() -> Driver<[CompatibilityTableElement]> {
        compatibilityManager
            .getSelectedSigns()
            .flatMap { [weak self] signs -> Single<(CompatibilitySigns?, Compatibility?)> in
                guard let self = self else {
                    return .never()
                }
                
                guard let signs = signs else {
                    return .never()
                }
                
                return self.compatibilityManager
                    .obtainCompatibility(forceUpdate: false,
                                         signCode1: signs.signCode1,
                                         signCode2: signs.signCode2)
                    .map { (signs, $0) }
            }
            .map { stub -> [CompatibilityTableElement] in
                let (signs, compatibility) = stub
                
                guard let signs = signs, let compatibility = compatibility else {
                    return []
                }
                
                var result = [CompatibilityTableElement]()
                
                result.append(.images(signs.signCode1, signs.signCode2))
                
                result.append(.offset(24.scale))
                
                result.append(.names(signs.signCode1, signs.signCode2))
                
                result.append(.offset(24.scale))
                
                return result
            }
            .asDriver(onErrorJustReturn: [])
    }
}
