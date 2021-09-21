//
//  ContentManager.swift
//  Astra
//
//  Created by Andrey Chernyshev on 14.08.2021.
//

import RxSwift

protocol ContentManager {
    func obtainDashboard() -> Single<Dashboard?>
    func obtainHoroFull() -> Single<HoroFull?>
    func obtainLunarFull() -> Single<LunarFull?>
    
    // MARK: Sign
    func signsDates() -> [SignDate]
    func signDate(at date: Date) -> SignDate?
    func obtainZodiacQuote() -> Single<String?>
}
