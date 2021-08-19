//
//  TarotType.swift
//  Astra
//
//  Created by Andrey Chernyshev on 19.08.2021.
//

enum TarotType: String, Codable {
    case daily, love, career, money
    
    init?(code: Int) {
        switch code {
        case 0:
            self = .daily
        case 1:
            self = .love
        case 2:
            self = .career
        case 3:
            self = .money
        default:
            return nil
        }
    }
    
    var code: Int {
        switch self {
        case .daily:
            return 0
        case .love:
            return 1
        case .career:
            return 2
        case .money:
            return 3
        }
    }
}

// MARK: Hashable
extension TarotType: Hashable {}
