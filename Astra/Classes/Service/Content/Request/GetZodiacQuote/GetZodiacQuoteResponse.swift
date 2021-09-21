//
//  GetZodiacQuoteResponse.swift
//  Astra
//
//  Created by Andrey Chernyshev on 21.09.2021.
//

final class GetZodiacQuoteResponse {
    static func map(from response: Any) -> String? {
        guard
            let json = response as? [String: Any],
            let data = json["_data"] as? [String: Any]
        else {
            return nil
        }
        
        return data["quote"] as? String
    }
}
