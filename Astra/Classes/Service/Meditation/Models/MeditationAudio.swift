//
//  MeditationAudio.swift
//  Astra
//
//  Created by Andrey Chernyshev on 24.08.2021.
//

struct MeditationAudio {
    let id: Int
    let title: String
    let duration: Int // секунды
    let imageUrl: String
    let audioUrl: String
    let paid: Bool
}

// MARK: Codable
extension MeditationAudio: Codable {}

// MARK: Hashable
extension MeditationAudio: Hashable {}
