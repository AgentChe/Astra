//
//  NatalManagerCore.swift
//  Astra
//
//  Created by Andrey Chernyshev on 29.09.2021.
//

import RxSwift

final class NatalManagerCore: NatalManager {}

// MARK: Public
extension NatalManagerCore {
    func obtainNatal() -> Single<Natal?> {
        guard let userToken = SessionManagerCore().getSession()?.userToken else {
            return .error(SignError.tokenNotFound)
        }
        
        let request = GetNatalRequest(userToken: userToken,
                                      locale: UIDevice.deviceLanguageCode ?? "en")
        
        return SDKStorage.shared
            .restApiTransport
            .callServerApi(requestBody: request)
            .map { GetNatalResponse.map(from: $0) }
    }
}
