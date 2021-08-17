//
//  HoroFullArticle.swift
//  Astra
//
//  Created by Andrey Chernyshev on 17.08.2021.
//

struct HoroFullArticle {
    let period: String
    let content: [HoroContent]
}

// MARK: Codable
extension HoroFullArticle: Codable {}

// MARK: Hashable
extension HoroFullArticle: Hashable {}
