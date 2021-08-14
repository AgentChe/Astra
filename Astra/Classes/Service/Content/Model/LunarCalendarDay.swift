//
//  LunarCalendarDay.swift
//  Astra
//
//  Created by Andrey Chernyshev on 14.08.2021.
//

struct LunarCalendarDay {
    let code: String
    let number: String
    let offset: Int
    let highlighted: Bool
}

// MARK: Codable
extension LunarCalendarDay: Codable {}

// MARK: Hashable
extension LunarCalendarDay: Hashable {}
