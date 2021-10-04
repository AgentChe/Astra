//
//  UserManagerCore.swift
//  Astra
//
//  Created by Andrey Chernyshev on 13.08.2021.
//

import RxSwift

final class UserManagerCore: UserManager {}

// MARK: Public
extension UserManagerCore {
    func set(gender: Int? = nil,
             name: String? = nil,
             birthDate: String? = nil,
             birthTime: String? = nil,
             cityId: Int? = nil,
             feelToday: Int? = nil,
             marital: Int? = nil,
             partnerZodiac: Int? = nil,
             goals: [Int]? = nil,
             enjoy: [Int]? = nil,
             notificationKey: String? = nil) -> Single<Void> {
        guard let userToken = SessionManagerCore().getSession()?.userToken else {
            return .error(SignError.tokenNotFound)
        }
        
        let request = SetRequest(userToken: userToken,
                                 gender: gender,
                                 name: name,
                                 birthDate: birthDate,
                                 birthTime: birthTime,
                                 cityId: cityId,
                                 feelToday: feelToday,
                                 marital: marital,
                                 partnerZodiac: partnerZodiac,
                                 goals: goals,
                                 enjoy: enjoy,
                                 notificationKey: notificationKey)
        
        return SDKStorage.shared
            .restApiTransport
            .callServerApi(requestBody: request)
            .map { _ in Void() }
    }
    
    func searchCities(with name: String) -> Single<[City]> {
        SDKStorage.shared
            .restApiTransport
            .callServerApi(requestBody: GetCitiesRequest(name: name))
            .map { GetCitiesResponse.map(from: $0) }
    }
    
    func add(city name: String) -> Single<City?> {
        SDKStorage.shared
            .restApiTransport
            .callServerApi(requestBody: AddCityRequest(name: name))
            .map { AddCityResponse.map(from: $0, name: name) }
    }
}
