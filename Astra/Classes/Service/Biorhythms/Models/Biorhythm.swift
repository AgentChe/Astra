//
//  Biorhythm.swift
//  Astra
//
//  Created by Andrey Chernyshev on 14.09.2021.
//

struct Biorhythm {
    let percent: Double
    let text: String
    let percentsGraph: [Double]
}

// MARK: Codable
extension Biorhythm: Codable {}

// MARK: Hashable
extension Biorhythm: Hashable {}
