//
//  GetPaygate2Response.swift
//  Astra
//
//  Created by Andrey Chernyshev on 22.09.2021.
//

final class GetPaygate2Response {
    static func map(from response: Any) -> PaygateSource2? {
        guard
            let json = response as? [String: Any],
            let data = json["_data"] as? [String: Any],
            let options = data["options"] as? [[String: Any]],
            options.count == 3,
            let first = mapOptionSource(optionJSON: options[0]),
            let second = mapOptionSource(optionJSON: options[1]),
            let third = mapOptionSource(optionJSON: options[2])
        else {
            return nil
        }
        
        return PaygateSource2(first: first,
                              second: second,
                              third: third)
    }
}

// MARK: Private
private extension GetPaygate2Response {
    static func mapOptionSource(optionJSON: [String: Any]) -> PaygateOptionSource? {
        guard
            let productId = optionJSON["product_id"] as? String,
            let title = optionJSON["title"] as? String,
            let caption = optionJSON["caption"] as? String,
            let subcaption = optionJSON["subcaption"] as? String
        else {
            return nil
        }
        
        return PaygateOptionSource(productId: productId,
                                   title: title,
                                   caption: String(format: "%@\n%@", caption, subcaption),
                                   div: optionJSON["div"] as? Int ?? 1,
                                   save: optionJSON["save"] as? String,
                                   isSubscription: optionJSON["is_subscription"] as? Bool ?? false)
    }
}
