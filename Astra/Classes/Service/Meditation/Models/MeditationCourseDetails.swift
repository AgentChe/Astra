//
//  MeditationCourseDetails.swift
//  Astra
//
//  Created by Andrey Chernyshev on 24.08.2021.
//

struct MeditationCourseDetails {
    let title: String
    let description: String
    let longDescription: String
    let imageUrl: String
    let audios: [MeditationAudio]
}

// MARK: Codable
extension MeditationCourseDetails: Codable {}

// MARK: Hashable
extension MeditationCourseDetails: Hashable {}
