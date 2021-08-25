//
//  MeditationDashboardCollectionSection.swift
//  Astra
//
//  Created by Andrey Chernyshev on 25.08.2021.
//

struct MeditationDashboardCollectionSection {
    enum Code {
        case daily
        case courses
        case group(String)
    }
    
    let code: Code
    let elements: [MeditationDashboardCollectionElement]
}
