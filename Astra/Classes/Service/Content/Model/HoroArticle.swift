//
//  HoroArticle.swift
//  Astra
//
//  Created by Andrey Chernyshev on 14.08.2021.
//

struct HoroArticle {
    let type: String
    let text: String
}

// MARK: Codable
extension HoroArticle: Codable {}

// MARK: Hashable
extension HoroArticle: Hashable {}
