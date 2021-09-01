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
             city: String?,
             feelToday: Int?,
             marital: Int?,
             partnerZodiac: Int?,
             goals: [Int]?,
             enjoy: [Int]?,
             notificationKey: String?) -> Single<Void>
}
