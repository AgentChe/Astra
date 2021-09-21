//
//  GetDashboardResponse.swift
//  Astra
//
//  Created by Andrey Chernyshev on 14.08.2021.
//

final class GetDashboardResponse {
    static func map(from response: Any) -> Dashboard? {
        guard
            let json = response as? [String: Any],
            let data = json["_data"] as? [String: Any],
            let dashboardJSON = data["dashboard"] as? [String: Any]
        else {
            return nil
        }
        
        let name = dashboardJSON["name"] as? String
        let sign = mapSign(json: dashboardJSON)
        let birthdate = dashboardJSON["birthdate"] as? String
        
        let horoImage = dashboardJSON["horoscopes_image"] as? String
        let horos = mapHoros(json: dashboardJSON)
        
        let charts = mapCharts(json: dashboardJSON)
        
        let biorhythmsJSON = dashboardJSON["biorhythms"] as? [String: Any] ?? [:]
        let biorhythmsPhysical = biorhythmsJSON["physical"] as? [Double] ?? []
        let biorhythmsEmotional = biorhythmsJSON["emotional"] as? [Double] ?? []
        let biorhythmsIntellectual = biorhythmsJSON["intellectual"] as? [Double] ?? []
        
        let lunar = mapLunar(json: dashboardJSON)
        
        return Dashboard(name: name,
                         sign: sign,
                         birthdate: birthdate,
                         horoImage: horoImage,
                         horos: horos,
                         charts: charts,
                         biorhythmsPhysical: biorhythmsPhysical,
                         biorhythmsEmotional: biorhythmsEmotional,
                         biorhythmsIntellectual: biorhythmsIntellectual,
                         lunar: lunar)
    }
}

// MARK: Privates
private extension GetDashboardResponse {
    static func mapSign(json: [String: Any]) -> Sign? {
        guard
            let code = json["sign_code"] as? Int,
            let signCode = Sign.Code(code: code),
            let name = json["sign_name"] as? String
        else {
            return nil
        }
        
        return Sign(code: signCode, name: name)
    }
    
    static func mapHoros(json: [String: Any]) -> [Horo] {
        guard let jsonArray = json["horoscopes"] as? [[String: Any]] else {
            return []
        }
        
        return jsonArray.compactMap { jsonElement -> Horo? in
            guard
                let period = jsonElement["period"] as? String,
                let contentJSON = jsonElement["content"] as? [String: Any],
                let type = contentJSON["type"] as? String,
                let text = contentJSON["text"] as? String,
                let iconCode = contentJSON["icon_code"] as? Int
            else {
                return nil
            }
            
            let content = HoroContent(type: type,
                                      text: text,
                                      iconCode: iconCode)
            
            return Horo(period: period, content: content)
        }
    }
    
    static func mapCharts(json: [String: Any]) -> [Chart] {
        guard let jsonArray = json["current_chart"] as? [[String: Any]] else {
            return []
        }
        
        return jsonArray.compactMap { json -> Chart? in
            guard
                let iconCode = json["icon_code"] as? Int,
                let title = json["title"] as? String,
                let date = json["dates"] as? String,
                let text = json["text"] as? String
            else {
                return nil
            }
            
            return Chart(iconCode: iconCode,
                         title: title,
                         date: date,
                         text: text)
        }
    }
    
    static func mapLunar(json: [String: Any]) -> Lunar? {
        guard
            let lunarJSON = json["lunar"] as? [String: Any],
            let daysArray = lunarJSON["calendar"] as? [[String: Any]],
            let articlesArray = lunarJSON["labels"] as? [[String: Any]]
        else {
            return nil
        }
        
        let days = daysArray.compactMap { json -> LunarCalendarDay? in
            guard
                let code = json["day_code"] as? String,
                let number = json["day_num"] as? String,
                let offset = json["shadow_offset"] as? Int,
                let highlighted = json["highlighted"] as? Bool
            else {
                return nil
            }
            
            return LunarCalendarDay(code: code,
                                    number: number,
                                    offset: offset,
                                    highlighted: highlighted)
        }
        
        let articles = articlesArray.compactMap { json -> LunarArticle? in
            guard
                let code = json["label"] as? String,
                let number = json["value"] as? String
            else {
                return nil
            }
            
            return LunarArticle(label: code,
                                value: number)
        }
        
        return Lunar(days: days,
                     articles: articles)
    }
}
