//
//  CompatibilitySigns.swift
//  Astra
//
//  Created by Andrey Chernyshev on 22.08.2021.
//

struct CompatibilitySigns {
    let signCode1: Sign.Code
    let signCode2: Sign.Code
}

// MARK: Codable
extension CompatibilitySigns: Codable {}

// MARK: Hashable
extension CompatibilitySigns: Hashable {}
