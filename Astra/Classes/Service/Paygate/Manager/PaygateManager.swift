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
    
    func retrieveConfig(forceUpdate: Bool) -> Single<PaygateConfig?>
    func cachedConfig() -> PaygateConfig?
}
