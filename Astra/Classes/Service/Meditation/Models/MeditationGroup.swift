//
//  MeditationGroup.swift
//  Astra
//
//  Created by Andrey Chernyshev on 24.08.2021.
//

struct MeditationGroup {
    let title: String
    let audios: [MeditationAudio]
}

// MARK: Codable
extension MeditationGroup: Codable {}

// MARK: Hashable
extension MeditationGroup: Hashable {}
