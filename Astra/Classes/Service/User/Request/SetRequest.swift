//
//  SetRequest.swift
//  Astra
//
//  Created by Andrey Chernyshev on 13.08.2021.
//

import Alamofire

struct SetRequest: APIRequestBody {
    private let userToken: String
    private let gender: Int?
    private let name: String?
    private let birthDate: String?
    private let birthTime: String?
    private let cityId: Int?
    private let feelToday: Int?
    private let marital: Int?
    private let partnerZodiac: Int?
    private let goals: [Int]?
    private let enjoy: [Int]?
    private let notificationKey: String?
    
    init(userToken: String,
         gender: Int? = nil,
         name: String? = nil,
         birthDate: String? = nil,
         birthTime: String? = nil,
         cityId: Int? = nil,
         feelToday: Int? = nil,
         marital: Int? = nil,
         partnerZodiac: Int? = nil,
         goals: [Int]? = nil,
         enjoy: [Int]? = nil,
         notificationKey: String? = nil) {
        self.userToken = userToken
        self.gender = gender
        self.name = name
        self.birthDate = birthDate
        self.birthTime = birthTime
        self.cityId = cityId
        self.feelToday = feelToday
        self.marital = marital
        self.partnerZodiac = partnerZodiac
        self.goals = goals
        self.enjoy = enjoy
        self.notificationKey = notificationKey
    }
    
    var url: String {
        GlobalDefinitions.domainUrl + "/api/users/set"
    }
    
    var method: HTTPMethod {
        .post
    }
    
    var parameters: Parameters? {
        var params: [String: Any] = [
            "_api_key": GlobalDefinitions.apiKey,
            "_user_token": userToken
        ]
        
        if let gender = self.gender {
            params["gender"] = gender
        }
        
        if let name = self.name {
            params["name"] = name
        }
        
        if let birthDate = self.birthDate {
            params["birthdate"] = birthDate
        }
        
        if let birthTime = self.birthTime {
            params["birth_time"] = birthTime
        }
        
        if let cityId = self.cityId {
            params["city_id"] = cityId
        }
        
        if let feelToday = self.feelToday {
            params["feelToday"] = feelToday
        }
        
        if let marital = self.marital {
            params["marital"] = marital
        }
        
        if let partnerZodiac = self.partnerZodiac {
            params["partnerZodiac"] = partnerZodiac
        }
        
        if let goals = self.goals {
            params["goals"] = goals
        }
        
        if let enjoy = self.enjoy {
            params["enjoy"] = enjoy
        }
        
        if let notificationKey = self.notificationKey {
            params["notification_key"] = notificationKey
        }
        
        return params
    }
}
