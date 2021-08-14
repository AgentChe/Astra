//
//  ContentManagerCore.swift
//  Astra
//
//  Created by Andrey Chernyshev on 14.08.2021.
//

import RxSwift

final class ContentManagerCore: ContentManager {}

// MARK: Public
extension ContentManagerCore {
    func obtainDashboard() -> Single<Dashboard?> {
        guard let userToken = SessionManagerCore().getSession()?.userToken else {
            return .error(SignError.tokenNotFound)
        }
        
        let request = GetDashboardRequest(userToken: userToken,
                                          locale: UIDevice.deviceLanguageCode ?? "en")
        
        return SDKStorage.shared
            .restApiTransport
            .callServerApi(requestBody: request)
            .map { GetDashboardResponse.map(from: $0) }
    }
}
