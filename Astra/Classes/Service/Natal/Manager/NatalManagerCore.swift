//
//  NatalManagerCore.swift
//  Astra
//
//  Created by Andrey Chernyshev on 29.09.2021.
//

import RxSwift

final class NatalManagerCore: NatalManager {
    private let defaultRequestWrapper = DefaultRequestWrapper()
}

// MARK: Public
extension NatalManagerCore {
    func obtainNatal() -> Single<Natal?> {
        guard let userToken = SessionManager().getSession()?.userToken else {
            return .error(SignError.tokenNotFound)
        }
        
        let request = GetNatalRequest(userToken: userToken,
                                      locale: UIDevice.deviceLanguageCode ?? "en")
        
        return defaultRequestWrapper
            .callServerApi(requestBody: request)
            .map { GetNatalResponse.map(from: $0) }
    }
}
