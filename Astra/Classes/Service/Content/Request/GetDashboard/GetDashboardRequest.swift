//
//  GetDashboardRequest.swift
//  Astra
//
//  Created by Andrey Chernyshev on 14.08.2021.
//

import Alamofire

struct GetDashboardRequest: APIRequestBody {
    let userToken: String
    let locale: String
    
    var url: String {
        GlobalDefinitions.domainUrl + "/api/content/dashboard"
    }
    
    var method: HTTPMethod {
        .post
    }
    
    var parameters: Parameters? {
        [
            "_api_key": GlobalDefinitions.apiKey,
            "_user_token": userToken,
            "locale": locale
        ]
    }
}
