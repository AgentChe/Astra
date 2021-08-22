//
//  GetCompatibilitiesRequest.swift
//  Astra
//
//  Created by Andrey Chernyshev on 22.08.2021.
//

import Alamofire

struct GetCompatibilitiesRequest: APIRequestBody {
    let userToken: String
    let locale: String
    
    var url: String {
        GlobalDefinitions.domainUrl + "/api/content/compatibility"
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
