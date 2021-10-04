//
//  OnboardedRequest.swift
//  Astra
//
//  Created by Andrey Chernyshev on 04.10.2021.
//

import Alamofire

struct OnboardedRequest: APIRequestBody {
    let userToken: String
    
    var url: String {
        GlobalDefinitions.domainUrl + "/api/users/onboarded"
    }
    
    var method: HTTPMethod {
        .post
    }
    
    var parameters: Parameters? {
        [
            "_api_key": GlobalDefinitions.apiKey,
            "_user_token": userToken
        ]
    }
}
