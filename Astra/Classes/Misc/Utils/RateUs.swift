//
//  RateUs.swift
//  Astra
//
//  Created by Andrey Chernyshev on 18.08.2021.
//

import StoreKit

final class RateUs {
    static func requestReview() {
        SKStoreReviewController.requestReview()
    }
}
