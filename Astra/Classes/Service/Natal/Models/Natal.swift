//
//  Natal.swift
//  Astra
//
//  Created by Andrey Chernyshev on 29.09.2021.
//

struct Natal {
    let imageUrl: String?
    let articles: [NatalArticle]
}

// MARK: Codable
extension Natal: Codable {}

// MARK: Hashable
extension Natal: Hashable {}
