//
//  AddCityRequest.swift
//  Astra
//
//  Created by Andrey Chernyshev on 04.09.2021.
//

import Alamofire

struct AddCityRequest: APIRequestBody {
    let name: String
    
    var url: String {
        GlobalDefinitions.domainUrl + "/api/cities/add"
    }
    
    var method: HTTPMethod {
        .post
    }
    
    var parameters: Parameters? {
        [
            "_api_key": GlobalDefinitions.apiKey,
            "city": name
        ]
    }
}
