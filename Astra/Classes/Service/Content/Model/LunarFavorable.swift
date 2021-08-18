//
//  LunarFavorable.swift
//  Astra
//
//  Created by Andrey Chernyshev on 18.08.2021.
//

struct LunarFavorable {
    let type: String
    let value: String
}

// MARK: Codable
extension LunarFavorable: Codable {}

// MARK: Hashable
extension LunarFavorable: Hashable {}
