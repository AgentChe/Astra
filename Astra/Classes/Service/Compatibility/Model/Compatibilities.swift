//
//  Compatibilities.swift
//  Astra
//
//  Created by Andrey Chernyshev on 22.08.2021.
//

struct Compatibilities {
    let signCode: Sign.Code
    let matches: [Sign.Code: Compatibility]
}

// MARK: Codable
extension Compatibilities: Codable {}

// MARK: HashableHashable
extension Compatibilities: Hashable {}
