//
//  GetNatalRequest.swift
//  Astra
//
//  Created by Andrey Chernyshev on 29.09.2021.
//

import Alamofire

struct GetNatalRequest: APIRequestBody {
    let userToken: String
    let locale: String
    
    var url: String {
        GlobalDefinitions.domainUrl + "/api/content/natal"
    }
    
    var method: HTTPMethod {
        .post
    }
    
    var parameters: Parameters? {
        [
            "_api_key": GlobalDefinitions.apiKey,
            "_user_token": userToken,
            "locale": locale,
        ]
    }
}
