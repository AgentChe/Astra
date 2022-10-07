//
//  ContentManagerCore.swift
//  Astra
//
//  Created by Andrey Chernyshev on 14.08.2021.
//

import RxSwift

final class ContentManagerCore: ContentManager {
    private let defaultRequestWrapper = DefaultRequestWrapper()
}

// MARK: Public
extension ContentManagerCore {
    func obtainDashboard() -> Single<Dashboard?> {
        guard let userToken = SessionManager().getSession()?.userToken else {
            return .error(SignError.tokenNotFound)
        }
        
        let request = GetDashboardRequest(userToken: userToken,
                                          locale: UIDevice.deviceLanguageCode ?? "en")
        
        return defaultRequestWrapper
            .callServerApi(requestBody: request)
            .map { GetDashboardResponse.map(from: $0) }
    }
    
    func obtainHoroFull() -> Single<HoroFull?> {
        guard let userToken = SessionManager().getSession()?.userToken else {
            return .error(SignError.tokenNotFound)
        }
        
        let request = GetHoroFullRequest(userToken: userToken,
                                         locale: UIDevice.deviceLanguageCode ?? "en")
        
        return defaultRequestWrapper
            .callServerApi(requestBody: request)
            .map { GetHoroFullResponse.map(from: $0) }
    }
    
    func obtainLunarFull() -> Single<LunarFull?> {
        guard let userToken = SessionManager().getSession()?.userToken else {
            return .error(SignError.tokenNotFound)
        }
        
        let request = GetLunarFullRequest(userToken: userToken,
                                          locale: UIDevice.deviceLanguageCode ?? "en")
        
        return defaultRequestWrapper
            .callServerApi(requestBody: request)
            .map { GetLunarFullResponse.map(from: $0) }
    }
}

// MARK: Public(Sign)
extension ContentManagerCore {
    func signsDates() -> [SignDate] {
        [
            SignDate(code: .aquarius, fromMonth: 1, fromDay: 20, beforeMonth: 2, beforeDay: 18),
            SignDate(code: .pisces, fromMonth: 2, fromDay: 19, beforeMonth: 3, beforeDay: 20),
            SignDate(code: .aries, fromMonth: 3, fromDay: 21, beforeMonth: 4, beforeDay: 19),
            SignDate(code: .taurus, fromMonth: 4, fromDay: 20, beforeMonth: 5, beforeDay: 20),
            SignDate(code: .gemini, fromMonth: 5, fromDay: 21, beforeMonth: 6, beforeDay: 20),
            SignDate(code: .cancer, fromMonth: 6, fromDay: 21, beforeMonth: 7, beforeDay: 22),
            SignDate(code: .leo, fromMonth: 7, fromDay: 23, beforeMonth: 8, beforeDay: 22),
            SignDate(code: .virgo, fromMonth: 8, fromDay: 23, beforeMonth: 9, beforeDay: 22),
            SignDate(code: .libra, fromMonth: 9, fromDay: 23, beforeMonth: 10, beforeDay: 22),
            SignDate(code: .scorpio, fromMonth: 10, fromDay: 23, beforeMonth: 11, beforeDay: 21),
            SignDate(code: .sagittarius, fromMonth: 11, fromDay: 22, beforeMonth: 12, beforeDay: 21),
            SignDate(code: .capricorn, fromMonth: 12, fromDay: 22, beforeMonth: 1, beforeDay: 19)
        ]
    }
    
    func signDate(at date: Date) -> SignDate? {
        let selectedMonth = Calendar.current.component(.month, from: date)
        let selectedDay = Calendar.current.component(.day, from: date)
    
        for signDate in signsDates() {
            if signDate.fromMonth == selectedMonth && selectedDay >= signDate.fromDay {
                return signDate
            } else if signDate.beforeMonth == selectedMonth && selectedDay <= signDate.beforeDay {
                return signDate
            }
        }

        return nil
    }
    
    func obtainZodiacQuote() -> Single<String?> {
        guard let userToken = SessionManager().getSession()?.userToken else {
            return .error(SignError.tokenNotFound)
        }
        
        let request = GetZodiacQuoteRequest(userToken: userToken,
                                            locale: UIDevice.deviceLanguageCode ?? "en")
        
        return defaultRequestWrapper
            .callServerApi(requestBody: request)
            .map { GetZodiacQuoteResponse.map(from: $0) }
    }
}
