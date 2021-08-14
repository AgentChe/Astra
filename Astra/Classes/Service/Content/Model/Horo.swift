//
//  Horo.swift
//  Astra
//
//  Created by Andrey Chernyshev on 14.08.2021.
//

struct Horo {
    let period: String
    let articles: [HoroArticle]
}

// MARK: Codable
extension Horo: Codable {}

// MARK: Hashable
extension Horo: Hashable {}
