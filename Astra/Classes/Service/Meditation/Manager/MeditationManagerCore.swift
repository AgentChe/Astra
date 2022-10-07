//
//  MeditationManagerCore.swift
//  Astra
//
//  Created by Andrey Chernyshev on 24.08.2021.
//

import RxSwift

final class MeditationManagerCore: MeditationManager {
    private let defaultRequestWrapper = DefaultRequestWrapper()
}

// MARK: Public
extension MeditationManagerCore {
    func obtainDashboard() -> Single<MeditationDashboard?> {
        guard let userToken = SessionManager().getSession()?.userToken else {
            return .error(SignError.tokenNotFound)
        }
        
        let request = GetMeditationDashboardRequest(userToken: userToken,
                                                    locale: UIDevice.deviceLanguageCode ?? "en")
        
        return defaultRequestWrapper
            .callServerApi(requestBody: request)
            .map { GetMeditationDashboardResponse.map(from: $0) }
    }
    
    func obtainCourseDetails(courseId: Int) -> Single<MeditationCourseDetails?> {
        guard let userToken = SessionManager().getSession()?.userToken else {
            return .error(SignError.tokenNotFound)
        }
        
        let request = GetMeditationCourseDetailsRequest(userToken: userToken,
                                                        locale: UIDevice.deviceLanguageCode ?? "en",
                                                        courseId: courseId)
        
        return defaultRequestWrapper
            .callServerApi(requestBody: request)
            .map { GetMeditationCourseDetailsResponse.map(from: $0) }
    }
}
