//
//  GetPaygateResponse.swift
//  Astra
//
//  Created by Andrey Chernyshev on 12.09.2021.
//

final class GetPaygateResponse {
    static func map(from response: Any) -> PaygateSource? {
        guard
            let json = response as? [String: Any],
            let data = json["_data"] as? [String: Any],
            let options = data["options"] as? [[String: Any]],
            let firstJSON = options.first,
            let first = mapOptionSource(optionJSON: firstJSON),
            let secondJSON = options.last,
            let second = mapOptionSource(optionJSON: secondJSON)
        else {
            return nil
        }
        
        return PaygateSource(first: first, second: second)
    }
}

// MARK: Private
private extension GetPaygateResponse {
    static func mapOptionSource(optionJSON: [String: Any]) -> PaygateOptionSource? {
        guard
            let productId = optionJSON["product_id"] as? String,
            let title = optionJSON["title"] as? String,
            let caption = optionJSON["caption"] as? String
        else {
            return nil
        }
        
        return PaygateOptionSource(productId: productId,
                                   title: title,
                                   caption: caption,
                                   div: optionJSON["div"] as? Int ?? 1,
                                   save: optionJSON["save"] as? String,
                                   isSubscription: optionJSON["is_subscription"] as? Bool ?? false)
    }
}
