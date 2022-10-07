//
//  UserManager.swift
//  Astra
//
//  Created by Andrey Chernyshev on 13.08.2021.
//

import RxSwift

protocol UserManager {
    func set(gender: Int?,
             name: String?,
             birthDate: String?,
             birthTime: String?,
             cityId: Int?,
             feelToday: Int?,
             marital: Int?,
             partnerZodiac: Int?,
             goals: [Int]?,
             enjoy: [Int]?,
             notificationKey: String?) -> Single<Void>
    func syncTokens(oldToken: String, newToken: String) -> Single<Void>
    func login(userToken: String) -> Single<Void>
    
    func onboarded() -> Single<Void>
    
    // MARK: City
    func searchCities(with name: String) -> Single<[City]>
    func add(city name: String) -> Single<City?>
}
