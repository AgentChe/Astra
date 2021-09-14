//
//  GetBiorhythmsRequest.swift
//  Astra
//
//  Created by Andrey Chernyshev on 14.09.2021.
//

import Alamofire

struct GetBiorhythmsRequest: APIRequestBody {
    let userToken: String
    let locale: String
    
    var url: String {
        GlobalDefinitions.domainUrl + "/api/payments/paygate"
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
