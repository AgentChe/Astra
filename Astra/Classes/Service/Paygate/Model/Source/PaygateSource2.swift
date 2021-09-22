//
//  PaygateSource2.swift
//  Astra
//
//  Created by Andrey Chernyshev on 22.09.2021.
//

struct PaygateSource2 {
    let first: PaygateOptionSource
    let second: PaygateOptionSource
    let third: PaygateOptionSource
}

// MARK: Codable
extension PaygateSource2: Codable {}

// MARK: Hashable
extension PaygateSource2: Hashable {}
