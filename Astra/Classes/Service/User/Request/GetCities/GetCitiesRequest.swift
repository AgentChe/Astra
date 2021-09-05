//
//  GetCitiesRequest.swift
//  Astra
//
//  Created by Andrey Chernyshev on 04.09.2021.
//

import Alamofire

struct GetCitiesRequest: APIRequestBody {
    let name: String
    
    var url: String {
        GlobalDefinitions.domainUrl + "/api/cities/search"
    }
    
    var method: HTTPMethod {
        .post
    }
    
    var parameters: Parameters? {
        [
            "_api_key": GlobalDefinitions.apiKey,
            "search": name
        ]
    }
}
