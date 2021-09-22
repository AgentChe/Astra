//
//  PaygateSource.swift
//  Astra
//
//  Created by Andrey Chernyshev on 12.09.2021.
//

struct PaygateSource {
    let first: PaygateOptionSource
    let second: PaygateOptionSource
}

// MARK: Codable
extension PaygateSource: Codable {}

// MARK: Hashable
extension PaygateSource: Hashable {}
