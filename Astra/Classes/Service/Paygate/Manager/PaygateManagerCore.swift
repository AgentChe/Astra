//
//  PaygateManagerCore.swift
//  Astra
//
//  Created by Andrey Chernyshev on 12.09.2021.
//

import RxSwift

final class PaygateManagerCore: PaygateManager {
    enum Constants {
        static let configKey = "paygate_manager_core_config_key"
    }
}

// MARK: Public
extension PaygateManagerCore {
    func obtainSource() -> Single<PaygateSource?> {
        guard let userToken = SessionManagerCore().getSession()?.userToken else {
            return .error(SignError.tokenNotFound)
        }
        
        let request = GetPaygateRequest(userToken: userToken,
                                        locale: UIDevice.deviceLanguageCode ?? "en",
                                        version: UIDevice.appVersion ?? 1)
        
        return SDKStorage.shared
            .restApiTransport
            .callServerApi(requestBody: request)
            .map { GetPaygateResponse.map(from: $0) }
    }
    
    func preparePrices(for source: PaygateSource) -> Single<Paygate?> {
        SDKStorage.shared
            .iapManager
            .obtainProducts(ids: [
                source.first.productId,
                source.second.productId
            ])
            .map { iapProducts -> [ProductPrice] in
                iapProducts.map { ProductPrice(product: $0.product) }
            }
            .map { productPrices -> Paygate? in
                PreparePaygatePricesMapper.map(source: source, prices: productPrices)
            }
    }
    
    func obtainSource2() -> Single<PaygateSource2?> {
        guard let userToken = SessionManagerCore().getSession()?.userToken else {
            return .error(SignError.tokenNotFound)
        }
        
        let request = GetPaygate2Request(userToken: userToken,
                                         locale: UIDevice.deviceLanguageCode ?? "en",
                                         version: UIDevice.appVersion ?? 1)
        
        return SDKStorage.shared
            .restApiTransport
            .callServerApi(requestBody: request)
            .map { GetPaygate2Response.map(from: $0) }
    }
    
    func preparePrices2(for source: PaygateSource2) -> Single<Paygate2?> {
        SDKStorage.shared
            .iapManager
            .obtainProducts(ids: [
                source.first.productId,
                source.second.productId,
                source.third.productId
            ])
            .map { iapProducts -> [ProductPrice] in
                iapProducts.map { ProductPrice(product: $0.product) }
            }
            .map { productPrices -> Paygate2? in
                PreparePaygate2PricesMapper.map(source: source, prices: productPrices)
            }
    }
    
    func retrieveConfig(forceUpdate: Bool) -> Single<PaygateConfig?> {
        guard let userToken = SessionManagerCore().getSession()?.userToken else {
            return .error(SignError.tokenNotFound)
        }
        
        guard forceUpdate else {
            return getCachedConfig()
        }
        
        let request = GetPaygateConfigRequest(userToken: userToken,
                                              locale: UIDevice.deviceLanguageCode ?? "en")
        
        return SDKStorage.shared
            .restApiTransport
            .callServerApi(requestBody: request)
            .map { GetPaygateConfigResponse.map(from: $0) }
            .flatMap { [weak self] config in
                guard let self = self, let config = config else {
                    return .just(config)
                }
                
                return self.cache(config: config)
            }
    }
    
    func cachedConfig() -> PaygateConfig? {
        guard let data = UserDefaults.standard.data(forKey: Constants.configKey) else {
            return nil
        }
        
        return try? JSONDecoder().decode(PaygateConfig.self, from: data)
    }
}

// MARK: Private
private extension PaygateManagerCore {
    func getCachedConfig() -> Single<PaygateConfig?> {
        Single<PaygateConfig?>.create { [weak self] event in
            guard let self = self, let config = self.cachedConfig() else {
                event(.success(nil))
                return Disposables.create()
            }
            
            event(.success(config))
            
            return Disposables.create()
        }
    }
    
    func cache(config: PaygateConfig) -> Single<PaygateConfig?> {
        Single<PaygateConfig?>.create { event in
            guard let data = try? JSONEncoder().encode(config) else {
                event(.success(nil))
                return Disposables.create()
            }
            
            UserDefaults.standard.setValue(data, forKey: Constants.configKey)
            
            event(.success(config))
            
            return Disposables.create()
        }
    }
}
