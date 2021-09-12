//
//  Paygate.swift
//  Astra
//
//  Created by Andrey Chernyshev on 12.09.2021.
//

struct Paygate {
    let first: PaygateOption
    let second: PaygateOption
}

// MARK: Codable
extension Paygate: Codable {}

// MARK: Hashable
extension Paygate: Hashable {}
