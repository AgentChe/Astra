//
//  Dashboard.swift
//  Astra
//
//  Created by Andrey Chernyshev on 14.08.2021.
//

struct Dashboard {
    let name: String?
    let sign: Sign?
    let birthdate: String? // в формате отображения
    
    let horoImage: String?
    let horos: [Horo]
    
    let charts: [Chart]
    
    let lunar: Lunar?
}

// MARK: Codable
extension Dashboard: Codable {}

// MARK: Hashable
extension Dashboard: Hashable {}
