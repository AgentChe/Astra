//
//  MeditationDashboardCollectionElement.swift
//  Astra
//
//  Created by Andrey Chernyshev on 24.08.2021.
//

import CoreGraphics

enum MeditationDashboardCollectionElement {
    case offset(CGFloat)
    case daily(MeditationDashboardCollectionDailyElement)
    case title(String)
    case subTitle(String)
    case course(MeditationCourse)
    case audio(MeditationDashboardCollectionAudioElement)
}
