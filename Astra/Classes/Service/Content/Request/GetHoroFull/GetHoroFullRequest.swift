//
//  GetHoroFullRequest.swift
//  Astra
//
//  Created by Andrey Chernyshev on 17.08.2021.
//

import Alamofire

struct GetHoroFullRequest: APIRequestBody {
    let userToken: String
    let locale: String
    
    var url: String {
        GlobalDefinitions.domainUrl + "/api/content/horoscopes"
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
