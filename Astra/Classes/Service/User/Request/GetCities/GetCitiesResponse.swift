//
//  GetCitiesResponse.swift
//  Astra
//
//  Created by Andrey Chernyshev on 04.09.2021.
//

final class GetCitiesResponse {
    static func map(from response: Any) -> [City] {
        guard
            let json = response as? [String: Any],
            let data = json["_data"] as? [[String: Any]]
        else {
            return []
        }
        
        return data.compactMap { cityJSON -> City? in
            guard
                let id = cityJSON["id"] as? Int,
                let name = cityJSON["name"] as? String
            else {
                return nil
            }
            
            return City(id: id,
                        name: name)
        }
    }
}
