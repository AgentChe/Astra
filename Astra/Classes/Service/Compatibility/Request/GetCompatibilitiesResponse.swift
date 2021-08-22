//
//  GetCompatibilitiesResponse.swift
//  Astra
//
//  Created by Andrey Chernyshev on 22.08.2021.
//

final class GetCompatibilitiesResponse {
    static func map(from response: Any) -> [Compatibilities] {
        guard
            let json = response as? [String: Any],
            let data = json["_data"] as? [String: [String: Any]]
        else {
            return []
        }
        
        var result = [Compatibilities]()
        
        data.forEach { signsArray in
            guard let signCodeValue = Int(signsArray.key), let signCode = Sign.Code(code: signCodeValue) else {
                return
            }
            
            var matches = [Sign.Code: Compatibility]()
            
            signsArray.value.forEach { key, value in
                guard let signCodeValueSub = Int(key), let signCodeSub = Sign.Code(code: signCodeValueSub) else {
                    return
                }
                
                guard let element = value as? [String: Any] else {
                    return
                }
                
                guard
                    let text = element["compatibility"] as? String,
                    let love = element["love_score"] as? Int,
                    let trust = element["trust_score"] as? Int,
                    let emotions = element["emotions_score"] as? Int,
                    let values = element["values_score"] as? Int
                else {
                    return
                }
                
                let compatibility = Compatibility(compatibility: text,
                                                  loveScore: love,
                                                  trustScore: trust,
                                                  emotionsScore: emotions,
                                                  valuesScore: values)
                
                matches[signCodeSub] = compatibility
            }
            
            let compatibilities = Compatibilities(signCode: signCode, matches: matches)
            result.append(compatibilities)
        }
        
        return result
    }
}
