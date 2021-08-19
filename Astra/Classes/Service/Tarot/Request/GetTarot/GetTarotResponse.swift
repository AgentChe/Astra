//
//  GetTarotResponse.swift
//  Astra
//
//  Created by Andrey Chernyshev on 19.08.2021.
//

final class GetTarotResponse {
    static func map(from response: Any, type: TarotType) -> Tarot? {
        guard
            let json = response as? [String: Any],
            let data = json["_data"] as? [String: Any]
        else {
            return nil
        }
        
        guard
            let name = data["name"] as? String,
            let tags = data["tags"] as? [String],
            let image = data["tarot_img"] as? String,
            let reversed = data["reversed"] as? Bool,
            let description = data["description"] as? String
        else {
            return nil
        }
        
        // TODO
        return Tarot(type: type,
                     name: name,
                     tags: tags,
                     image: image,
                     reversed: true,
                     description: description)
    }
}
