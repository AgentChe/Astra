//
//  Chart.swift
//  Astra
//
//  Created by Andrey Chernyshev on 14.08.2021.
//

struct Chart {
    let iconCode: Int
    let title: String
    let date: String // в формате отображения
    let text: String
}

// MARK: Codable
extension Chart: Codable {}

// MARK: Hashable
extension Chart: Hashable {}
