//
//  ContentManager.swift
//  Astra
//
//  Created by Andrey Chernyshev on 14.08.2021.
//

import RxSwift

protocol ContentManager {
    func obtainDashboard() -> Single<Dashboard?>
}
