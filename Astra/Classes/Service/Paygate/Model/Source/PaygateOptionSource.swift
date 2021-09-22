//
//  PaygateOptionSource.swift
//  Astra
//
//  Created by Andrey Chernyshev on 12.09.2021.
//

struct PaygateOptionSource {
    let productId: String
    let title: String
    let caption: String
    let div: Int
    let save: String?
}

// MARK: Codable
extension PaygateOptionSource: Codable {}

// MARK: Hashable
extension PaygateOptionSource: Hashable {}
