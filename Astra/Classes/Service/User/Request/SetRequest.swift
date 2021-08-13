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
    private let goals: [Int]?
    private let enjoy: [Int]?
    private let notificationKey: String?
    
    init(userToken: String,
         gender: Int? = nil,
         name: String? = nil,
         birthDate: String? = nil,
         goals: [Int]? = nil,
         enjoy: [Int]? = nil,
         notificationKey: String? = nil) {
        self.userToken = userToken
        self.gender = gender
        self.name = name
        self.birthDate = birthDate
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
