//
//  PaygateManager.swift
//  Astra
//
//  Created by Andrey Chernyshev on 12.09.2021.
//

import RxSwift

protocol PaygateManager {
    func obtainSource() -> Single<PaygateSource?>
    func preparePrices(for source: PaygateSource) -> Single<Paygate?>
    
    func obtainSource2() -> Single<PaygateSource2?>
    func preparePrices2(for source: PaygateSource2) -> Single<Paygate2?>
    
    func retrieveConfig(forceUpdate: Bool) -> Single<PaygateConfig?>
    func cachedConfig() -> PaygateConfig?
}
