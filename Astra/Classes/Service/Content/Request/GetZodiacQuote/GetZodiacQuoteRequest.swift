//
//  GetZodiacQuoteRequest.swift
//  Astra
//
//  Created by Andrey Chernyshev on 21.09.2021.
//

import Alamofire

struct GetZodiacQuoteRequest: APIRequestBody {
    let userToken: String
    let locale: String
    
    var url: String {
        GlobalDefinitions.domainUrl + "/api/content/zodiac_quote"
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
