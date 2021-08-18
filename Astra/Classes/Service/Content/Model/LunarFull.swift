//
//  LunarFull.swift
//  Astra
//
//  Created by Andrey Chernyshev on 18.08.2021.
//

struct LunarFull {
    let days: [LunarCalendarDay]
    let articles: [LunarArticle]
    let favorables: [LunarFavorable]
    let unfavorables: [LunarFavorable]
    let luckyNumbers: [Int]
}

// MARK: Codable
extension LunarFull: Codable {}

// MARK: Hashable
extension LunarFull: Hashable {}
