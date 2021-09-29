//
//  GetNatalResponse.swift
//  Astra
//
//  Created by Andrey Chernyshev on 29.09.2021.
//

final class GetNatalResponse {
    static func map(from response: Any) -> Natal? {
        guard
            let json = response as? [String: Any],
            let data = json["_data"] as? [String: Any],
            let articlesArray = data["text"] as? [[String: Any]]
        else {
            return nil
        }
        
        let articles = articlesArray.compactMap { articleJSON -> NatalArticle? in
            guard
                let sort = articleJSON["sort"] as? Int,
                let iconCode = articleJSON["element"] as? Int,
                let title = articleJSON["title"] as? String,
                let subtitle = articleJSON["subtitle"] as? String,
                let text = articleJSON["text"] as? String
            else {
                return nil
            }
            
            return NatalArticle(sort: sort,
                                iconCode: iconCode,
                                title: title,
                                subtitle: subtitle,
                                text: text)
        }
        
        return Natal(imageUrl: data["image"] as? String,
                     articles: articles)
    }
}
