//
//  BiorhythmsManagerCore.swift
//  Astra
//
//  Created by Andrey Chernyshev on 14.09.2021.
//

import RxSwift

final class BiorhythmsManagerCore: BiorhythmsManager {}

// MARK: Public
extension BiorhythmsManagerCore {
    func obtainBiorhythms() -> Single<Biorhythms?> {
        guard let userToken = SessionManagerCore().getSession()?.userToken else {
            return .error(SignError.tokenNotFound)
        }
        
        let request = GetBiorhythmsRequest(userToken: userToken,
                                           locale: UIDevice.deviceLanguageCode ?? "en")
        
        return SDKStorage.shared
            .restApiTransport
            .callServerApi(requestBody: request)
            .map { GetBiorhythmsResponse.map(from: $0) }
    }
}
