//
//  NatalArticle.swift
//  Astra
//
//  Created by Andrey Chernyshev on 29.09.2021.
//

struct NatalArticle {
    let sort: Int
    let iconCode: Int
    let title: String
    let subtitle: String
    let text: String
}

// MARK: Codable
extension NatalArticle: Codable {}

// MARK: Hashable
extension NatalArticle: Hashable {}
