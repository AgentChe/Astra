//
//  Biorhythms.swift
//  Astra
//
//  Created by Andrey Chernyshev on 14.09.2021.
//

struct Biorhythms {
    let physical: Biorhythm
    let emotional: Biorhythm
    let intellectual: Biorhythm
}

// MARK: Codable
extension Biorhythms: Codable {}

// MARK: Hashable
extension Biorhythms: Hashable {}
