//
//  LunarArticle.swift
//  Astra
//
//  Created by Andrey Chernyshev on 14.08.2021.
//

struct LunarArticle {
    let label: String
    let value: String
}

// MARK: Codable
extension LunarArticle: Codable {}

// MARK: Hashable
extension LunarArticle: Hashable {}
