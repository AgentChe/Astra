//
//  MeditationManager.swift
//  Astra
//
//  Created by Andrey Chernyshev on 24.08.2021.
//

import RxSwift

protocol MeditationManager {
    func obtainDashboard() -> Single<MeditationDashboard?>
    func obtainCourseDetails(courseId: Int) -> Single<MeditationCourseDetails?>
}
