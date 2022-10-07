//
//  PreparePaygatePricesMapper.swift
//  Astra
//
//  Created by Andrey Chernyshev on 12.09.2021.
//

import Foundation

final class PreparePaygatePricesMapper {
    static func map(source: PaygateSource, prices: [ProductPrice]) -> Paygate? {
        guard
            let firstPrice = prices.first(where: { $0.id == source.first.productId }),
            let secondPrice = prices.first(where: { $0.id == source.second.productId })
        else {
            return nil
        }
        
        let first = makeOption(source: source.first, price: firstPrice)
        let second = makeOption(source: source.second, price: secondPrice)
        
        return Paygate(first: first, second: second)
    }
}

// MARK: Private
private extension PreparePaygatePricesMapper {
    static func makeOption(source: PaygateOptionSource, price: ProductPrice) -> PaygateOption {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = price.priceLocale
        
        let priceDiv: Double = price.priceValue / Double(source.div)
        let priceDivLocalized: String
        if priceDiv < 100 {
            formatter.maximumFractionDigits = 1
            priceDivLocalized = formatter.string(from: NSNumber(value: (priceDiv * 10).rounded() / 10)) ?? ""
        } else {
            formatter.maximumFractionDigits = 0
            priceDivLocalized = formatter.string(from: NSNumber(value: round(priceDiv))) ?? ""
        }
        
        formatter.maximumFractionDigits = price.priceValue.truncatingRemainder(dividingBy: 1) > 0 ? 2 : 0
        let priceLocalized = formatter.string(from: NSNumber(value: price.priceValue)) ?? ""
        
        let title = source.title
            .replacingOccurrences(of: "@price_div", with: priceDivLocalized)
            .replacingOccurrences(of: "@price", with: priceLocalized)
        
        let subTitle = source.caption
            .replacingOccurrences(of: "@price_div", with: priceDivLocalized)
            .replacingOccurrences(of: "@price", with: priceLocalized)
        
        return PaygateOption(productId: source.productId,
                             title: title,
                             subTitle: subTitle,
                             save: source.save,
                             isSubscription: source.isSubscription)
    }
}
