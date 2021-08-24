//
//  MeditationCourse.swift
//  Astra
//
//  Created by Andrey Chernyshev on 24.08.2021.
//

struct MeditationCourse {
    let id: Int
    let title: String
    let description: String
    let count: Int
    let imageUrl: String
}

// MARK: Codable
extension MeditationCourse: Codable {}

// MARK: Hashable
extension MeditationCourse: Hashable {}
