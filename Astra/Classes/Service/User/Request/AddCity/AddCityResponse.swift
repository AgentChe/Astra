//
//  AddCityResponse.swift
//  Astra
//
//  Created by Andrey Chernyshev on 04.09.2021.
//

final class AddCityResponse {
    static func map(from response: Any, name: String) -> City? {
        guard
            let json = response as? [String: Any],
            let data = json["_data"] as? [String: Any],
            let id = data["id"] as? Int
        else {
            return nil
        }
        
        return City(id: id, name: name)
    }
}
