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
        let horos = mapHoros(json: data)
        
        return HoroFull(image: image,
                        horos: horos)
    }
}

// MARK: Privates
private extension GetHoroFullResponse {
    static func mapHoros(json: [String: Any]) -> [Horo] {
        guard let horoscopesArray = json["horoscopes"] as? [[String: Any]] else {
            return []
        }
        
        var result = [Horo]()
        
        for horoscopeJSON in horoscopesArray {
            guard
                let period = horoscopeJSON["period"] as? String,
                let articlesArray = horoscopeJSON["articles"] as? [[String: Any]]
            else {
                continue
            }
            
            for articleJSON in articlesArray {
                guard
                    let type = articleJSON["header"] as? String,
                    let text = articleJSON["text"] as? String,
                    let iconCode = articleJSON["icon_code"] as? Int
                else {
                    continue
                }
                
                let content = HoroContent(type: type,
                                          text: text,
                                          iconCode: iconCode)
                
                let horo = Horo(period: period,
                                content: content)
                
                result.append(horo)
            }
        }
        
        return result
    }
}
