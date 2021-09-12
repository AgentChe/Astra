//
//  PaygateManagerCore.swift
//  Astra
//
//  Created by Andrey Chernyshev on 12.09.2021.
//

import RxSwift

final class PaygateManagerCore: PaygateManager {}

// MARK: Public
extension PaygateManagerCore {
    func obtainSource() -> Single<PaygateSource?> {
        guard let userToken = SessionManagerCore().getSession()?.userToken else {
            return .error(SignError.tokenNotFound)
        }
        
        let request = GetPaygateRequest(userToken: userToken,
                                        locale: UIDevice.deviceLanguageCode ?? "en")
        
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
}
