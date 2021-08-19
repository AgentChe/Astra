//
//  Tarot.swift
//  Astra
//
//  Created by Andrey Chernyshev on 19.08.2021.
//

struct Tarot {
    let type: TarotType
    let name: String
    let tags: [String]
    let image: String
    let reversed: Bool
    let description: String
}

// MARK: Codable
extension Tarot: Codable {}

// MARK: Hashable
extension Tarot: Hashable {}
