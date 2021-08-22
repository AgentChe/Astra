//
//  CompatibilityManager.swift
//  Astra
//
//  Created by Andrey Chernyshev on 22.08.2021.
//

import RxSwift

protocol CompatibilityManager {
    func obtainCompatibilities(forceUpdate: Bool) -> Single<[Compatibilities]>
    
    func obtainCompatibility(forceUpdate: Bool, signCode1: Sign.Code, signCode2: Sign.Code) -> Single<Compatibility?>
    
    func store(selected signs: CompatibilitySigns) -> Single<Void>
    func getSelectedSigns() -> Single<CompatibilitySigns?>
}
