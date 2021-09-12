//
//  PaygateOption.swift
//  Astra
//
//  Created by Andrey Chernyshev on 09.09.2021.
//

struct PaygateOption {
    let productId: String
    let title: String
    let subTitle: String
    let save: String?
}

// MARK: Codable
extension PaygateOption: Codable {}

// MARK: Hashable
extension PaygateOption: Hashable {}
