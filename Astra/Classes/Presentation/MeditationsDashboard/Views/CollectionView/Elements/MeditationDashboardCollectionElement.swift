//
//  MeditationDashboardCollectionElement.swift
//  Astra
//
//  Created by Andrey Chernyshev on 24.08.2021.
//

enum MeditationDashboardCollectionElement {
    case offset(CGFloat)
    case daily(DailyMeditation)
    case title(String)
    case subTitle(String)
    case course(MeditationCourse)
}
