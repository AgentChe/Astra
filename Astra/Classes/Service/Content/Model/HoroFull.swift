//
//  HoroFull.swift
//  Astra
//
//  Created by Andrey Chernyshev on 17.08.2021.
//

struct HoroFull {
    let image: String?
    let horos: [Horo]
}

// MARK: Codable
extension HoroFull: Codable {}

// MARK: Hashable
extension HoroFull: Hashable {}
