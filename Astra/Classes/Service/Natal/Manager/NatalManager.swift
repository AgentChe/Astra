//
//  NatalManager.swift
//  Astra
//
//  Created by Andrey Chernyshev on 29.09.2021.
//

import RxSwift

protocol NatalManager {
    func obtainNatal() -> Single<Natal?>
}
