//
//  GetMeditationCourseDetailsRequest.swift
//  Astra
//
//  Created by Andrey Chernyshev on 24.08.2021.
//

import Alamofire

struct GetMeditationCourseDetailsRequest: APIRequestBody {
    let userToken: String
    let locale: String
    let courseId: Int
    
    var url: String {
        GlobalDefinitions.domainUrl + "/api/content/meditations/course"
    }
    
    var method: HTTPMethod {
        .post
    }
    
    var parameters: Parameters? {
        [
            "_api_key": GlobalDefinitions.apiKey,
            "_user_token": userToken,
            "locale": locale,
            "course_id": courseId
        ]
    }
}
