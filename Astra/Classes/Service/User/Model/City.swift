//
//  City.swift
//  Astra
//
//  Created by Andrey Chernyshev on 04.09.2021.
//

struct City {
    let id: Int
    let name: String
}

// MARK: Codable
extension City: Codable {}

// MARK: Hashable
extension City: Hashable {}
