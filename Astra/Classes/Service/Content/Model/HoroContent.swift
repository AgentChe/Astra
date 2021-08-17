//
//  HoroContent.swift
//  Astra
//
//  Created by Andrey Chernyshev on 14.08.2021.
//

struct HoroContent {
    let type: String
    let text: String
    let iconCode: Int
}

// MARK: Codable
extension HoroContent: Codable {}

// MARK: Hashable
extension HoroContent: Hashable {}
