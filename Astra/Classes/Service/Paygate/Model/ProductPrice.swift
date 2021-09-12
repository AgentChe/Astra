//
//  ProductPrice.swift
//  Astra
//
//  Created by Andrey Chernyshev on 12.09.2021.
//

import StoreKit

struct ProductPrice {
    let id: String
    let priceLocalized: String
    let priceValue: Double
    let priceLocale: Locale
    let currency: String
}

// MARK: Make
extension ProductPrice {
    init(product: SKProduct) {
        id = product.productIdentifier
        priceLocalized = product.localizedPrice ?? ""
        priceValue = product.price.doubleValue
        priceLocale = product.priceLocale
        currency = product.priceLocale.currencyCode ?? ""
    }
    
    // TODO
    init(code: Int) {
        id = "app.astra.forever"
        priceLocalized = "$44.99"
        priceValue = 44.99
        priceLocale = Locale.current
        currency = Locale.current.currencyCode ?? ""
    }
    init(type: Int) {
        id = "app.astra.month"
        priceLocalized = "$24.99"
        priceValue = 24.99
        priceLocale = Locale.current
        currency = Locale.current.currencyCode ?? ""
    }
}
