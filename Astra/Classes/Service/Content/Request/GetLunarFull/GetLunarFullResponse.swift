//
//  GetLunarFullResponse.swift
//  Astra
//
//  Created by Andrey Chernyshev on 18.08.2021.
//

final class GetLunarFullResponse {
    static func map(from response: Any) -> LunarFull? {
        guard
            let json = response as? [String: Any],
            let data = json["_data"] as? [String: Any],
            let lunarJSON = data["lunar"] as? [String: Any]
        else {
            return nil
        }
        
        let calendarArray = (lunarJSON["calendar"] as? [[String: Any]]) ?? []
        let days = calendarArray.compactMap { calendarJSON -> LunarCalendarDay? in
            guard
                let code = calendarJSON["day_code"] as? String,
                let number = calendarJSON["day_num"] as? String,
                let offset = calendarJSON["shadow_offset"] as? Int,
                let highlighted = calendarJSON["highlighted"] as? Bool
            else {
                return nil
            }
            
            return LunarCalendarDay(code: code,
                                    number: number,
                                    offset: offset,
                                    highlighted: highlighted)
        }
        
        let articlesArray = (lunarJSON["labels"] as? [[String: Any]]) ?? []
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
        
        let favorableArray = (lunarJSON["favorable"] as? [[String: Any]]) ?? []
        let favorables = favorableArray.compactMap { json -> LunarFavorable? in
            guard
                let type = json["type"] as? String,
                let number = json["value"] as? String
            else {
                return nil
            }
            
            return LunarFavorable(type: type,
                                  value: number)
        }
        
        let unfavorableArray = (lunarJSON["unfavorable"] as? [[String: Any]]) ?? []
        let unfavorables = unfavorableArray.compactMap { json -> LunarFavorable? in
            guard
                let type = json["type"] as? String,
                let number = json["value"] as? String
            else {
                return nil
            }
            
            return LunarFavorable(type: type,
                                  value: number)
        }
        
        let luckyNumbers = (lunarJSON["lucky_numbers"] as? [Int]) ?? []
        
        return LunarFull(days: days,
                         articles: articles,
                         favorables: favorables,
                         unfavorables: unfavorables,
                         luckyNumbers: luckyNumbers)
    }
}
