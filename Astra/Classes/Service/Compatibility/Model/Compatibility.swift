//
//  Compatibility.swift
//  Astra
//
//  Created by Andrey Chernyshev on 22.08.2021.
//

struct Compatibility {
    let compatibility: String
    let loveScore: Int
    let trustScore: Int
    let emotionsScore: Int
    let valuesScore: Int
}

// MARK: Codable
extension Compatibility: Codable {}

// MARK: HashableHashable
extension Compatibility: Hashable {}
