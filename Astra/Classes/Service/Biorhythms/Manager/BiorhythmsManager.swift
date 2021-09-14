//
//  BiorhythmsManager.swift
//  Astra
//
//  Created by Andrey Chernyshev on 14.09.2021.
//

import RxSwift

protocol BiorhythmsManager {
    func obtainBiorhythms() -> Single<Biorhythms?>
}
