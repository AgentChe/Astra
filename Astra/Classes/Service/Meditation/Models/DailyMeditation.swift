//
//  DailyMeditation.swift
//  Astra
//
//  Created by Andrey Chernyshev on 24.08.2021.
//

struct DailyMeditation {
    let date: String
    let audio: MeditationAudio
}

// MARK: Codable
extension DailyMeditation: Codable {}

// MARK: Hashable
extension DailyMeditation: Hashable {}
