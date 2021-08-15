//
//  Horo.swift
//  Astra
//
//  Created by Andrey Chernyshev on 14.08.2021.
//

struct Horo {
    let period: String
    let content: HoroContent
}

// MARK: Codable
extension Horo: Codable {}

// MARK: Hashable
extension Horo: Hashable {}
