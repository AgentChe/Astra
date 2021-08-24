//
//  MeditationDashboard.swift
//  Astra
//
//  Created by Andrey Chernyshev on 24.08.2021.
//

struct MeditationDashboard {
    let daily: DailyMeditation?
    let courses: [MeditationCourse]
    let groupes: [MeditationGroup]
}

// MARK: Codable
extension MeditationDashboard: Codable {}

// MARK: Hashable
extension MeditationDashboard: Hashable {}
