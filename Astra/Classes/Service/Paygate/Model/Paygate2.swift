//
//  Paygate2.swift
//  Astra
//
//  Created by Andrey Chernyshev on 22.09.2021.
//

struct Paygate2 {
    let first: PaygateOption
    let second: PaygateOption
    let third: PaygateOption
}

// MARK: Codable
extension Paygate2: Codable {}

// MARK: Hashable
extension Paygate2: Hashable {}
