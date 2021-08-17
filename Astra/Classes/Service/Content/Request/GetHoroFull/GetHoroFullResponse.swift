//
//  GetHoroFullResponse.swift
//  Astra
//
//  Created by Andrey Chernyshev on 17.08.2021.
//

final class GetHoroFullResponse {
    static func map(from response: Any) -> HoroFull? {
        guard
            let json = response as? [String: Any],
            let data = json["_data"] as? [String: Any]
        else {
            return nil
        }
        
        let image = data["horoscopes_image"] as? String
        let articles = mapArticles(json: data)
        
        return HoroFull(image: image,
                        articles: articles)
    }
}

// MARK: Privates
private extension GetHoroFullResponse {
    static func mapArticles(json: [String: Any]) -> [HoroFullArticle] {
        guard let horoscopesArray = json["horoscopes"] as? [[String: Any]] else {
            return []
        }
        
        return horoscopesArray.compactMap { horoscopeJSON -> HoroFullArticle? in
            guard
                let period = horoscopeJSON["period"] as? String,
                let articlesArray = horoscopeJSON["articles"] as? [[String: Any]]
            else {
                return nil
            }
            
            let content = articlesArray.compactMap { articleJSON -> HoroContent? in
                guard
                    let type = articleJSON["header"] as? String,
                    let text = articleJSON["text"] as? String,
                    let iconCode = articleJSON["icon_code"] as? Int
                else {
                    return nil
                }
                
                return HoroContent(type: type,
                                   text: text,
                                   iconCode: iconCode)
            }
            
            return HoroFullArticle(period: period,
                                   content: content)
        }
    }
}
