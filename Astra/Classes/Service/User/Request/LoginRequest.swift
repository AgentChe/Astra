//
//  LoginRequest.swift
//  Astra
//
//  Created by Андрей Чернышев on 07.10.2022.
//

import Alamofire

struct LoginRequest: APIRequestBody {
    let userToken: String

    var url: String {
        GlobalDefinitions.domainUrl + "/api/users/login"
    }
    
    var method: HTTPMethod {
        .post
    }
    
    var parameters: Parameters? {
        [
            "_api_key": GlobalDefinitions.apiKey,
            "user_token": userToken,
            "platform": 1
        ]
    }
}
