//
//  Lunar.swift
//  Astra
//
//  Created by Andrey Chernyshev on 14.08.2021.
//

struct Lunar {
    let days: [LunarCalendarDay]
    let articles: [LunarArticle]
}

// MARK: Codable
extension Lunar: Codable {}

// MARK: Hashable
extension Lunar: Hashable {}
