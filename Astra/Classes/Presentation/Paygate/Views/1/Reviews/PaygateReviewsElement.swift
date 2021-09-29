//
//  PaygateReviewsElement.swift
//  Astra
//
//  Created by Andrey Chernyshev on 10.09.2021.
//

struct PaygateReviewsElement {
    let image: String
    let text: String
    let city: String
}

// MARK: Make
extension PaygateReviewsElement {
    static func makeCollection() -> [PaygateReviewsElement] {
        [
            PaygateReviewsElement(image: "Paygate.Icon.1",
                                  text: "Paygate.Review.1.Text".localized,
                                  city: "Paygate.Review.1.City".localized),
            
            PaygateReviewsElement(image: "Paygate.Icon.2",
                                  text: "Paygate.Review.2.Text".localized,
                                  city: "Paygate.Review.2.City".localized),
            
            PaygateReviewsElement(image: "Paygate.Icon.3",
                                  text: "Paygate.Review.3.Text".localized,
                                  city: "Paygate.Review.3.City".localized),
            
            PaygateReviewsElement(image: "Paygate.Icon.4",
                                  text: "Paygate.Review.4.Text".localized,
                                  city: "Paygate.Review.4.City".localized),
            
            PaygateReviewsElement(image: "Paygate.Icon.5",
                                  text: "Paygate.Review.5.Text".localized,
                                  city: "Paygate.Review.5.City".localized),
            
            PaygateReviewsElement(image: "Paygate.Icon.6",
                                  text: "Paygate.Review.6.Text".localized,
                                  city: "Paygate.Review.6.City".localized),
            
            PaygateReviewsElement(image: "Paygate.Icon.7",
                                  text: "Paygate.Review.7.Text".localized,
                                  city: "Paygate.Review.7.City".localized),
            
            PaygateReviewsElement(image: "Paygate.Icon.8",
                                  text: "Paygate.Review.8.Text".localized,
                                  city: "Paygate.Review.8.City".localized)
        ]
    }
}
