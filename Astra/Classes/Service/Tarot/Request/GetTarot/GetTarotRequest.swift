//
//  GetTarotRequest.swift
//  Astra
//
//  Created by Andrey Chernyshev on 19.08.2021.
//

import Alamofire

struct GetTarotRequest: APIRequestBody {
    let userToken: String
    let locale: String
    let type: Int
    
    var url: String {
        GlobalDefinitions.domainUrl + "/api/content/tarot"
    }
    
    var method: HTTPMethod {
        .post
    }
    
    var parameters: Parameters? {
        [
            "_api_key": GlobalDefinitions.apiKey,
            "_user_token": userToken,
            "locale": locale,
            "type": type
        ]
    }
}
