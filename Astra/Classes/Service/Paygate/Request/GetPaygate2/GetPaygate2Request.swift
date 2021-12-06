//
//  GetPaygate2Request.swift
//  Astra
//
//  Created by Andrey Chernyshev on 22.09.2021.
//

import Alamofire

struct GetPaygate2Request: APIRequestBody {
    let userToken: String
    let locale: String
    let version: Int
    
    var url: String {
        GlobalDefinitions.domainUrl + "/api/payments/paygate_alt"
    }
    
    var method: HTTPMethod {
        .post
    }
    
    var parameters: Parameters? {
        [
            "_api_key": GlobalDefinitions.apiKey,
            "_user_token": userToken,
            "locale": locale,
            "version": version
        ]
    }
}
