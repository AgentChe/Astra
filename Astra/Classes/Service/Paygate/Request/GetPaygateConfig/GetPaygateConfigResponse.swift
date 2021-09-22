//
//  GetPaygateConfigResponse.swift
//  Astra
//
//  Created by Andrey Chernyshev on 22.09.2021.
//

final class GetPaygateConfigResponse {
    static func map(from response: Any) -> PaygateConfig? {
        guard
            let json = response as? [String: Any],
            let data = json["_data"] as? [String: Any]
        else {
            return nil
        }
        
        let tarotJSON = data["tarot"] as? [String: Any] ?? [:]
        
        return PaygateConfig(variant: data["paygate_variant"] as? Int ?? 1,
                             afterOnboarding: data["after_onboarding"] as? Bool ?? false,
                             blockEverything: data["block_everything"] as? Bool ?? false,
                             horoscopes: data["horoscopes"] as? Bool ?? false,
                             tarotDaily: tarotJSON["daily"] as? Bool ?? false,
                             tarotLove: tarotJSON["love"] as? Bool ?? false,
                             tarotCareer: tarotJSON["career"] as? Bool ?? false,
                             tarotMoney: tarotJSON["money"] as? Bool ?? false,
                             lunar: data["lunar"] as? Bool ?? false,
                             biorhythms: data["biorhythms"] as? Bool ?? false,
                             compatibility: data["compatibility"] as? Bool ?? false)
    }
}
