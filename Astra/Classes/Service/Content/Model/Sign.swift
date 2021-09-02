//
//  Sign.swift
//  Astra
//
//  Created by Andrey Chernyshev on 14.08.2021.
//

struct Sign {
    enum Code: String, Codable {
        case aries // Овен
        case taurus // Телец
        case gemini // Близнецы
        case cancer // Рак
        case leo // Лев
        case virgo // Дева
        case libra // Весы
        case scorpio // Скорпион
        case sagittarius // Стрелец
        case capricorn // Козерог
        case aquarius // Водолей
        case pisces // Рыбы
        
        init?(code: Int) {
            switch code {
            case 1:
                self = .aries
            case 2:
                self = .taurus
            case 3:
                self = .gemini
            case 4:
                self = .cancer
            case 5:
                self = .leo
            case 6:
                self = .virgo
            case 7:
                self = .libra
            case 8:
                self = .scorpio
            case 9:
                self = .sagittarius
            case 10:
                self = .capricorn
            case 11:
                self = .aquarius
            case 12:
                self = .pisces
            default:
                return nil
            }
        }
    }
    
    let code: Code
    let name: String
}

// MARK: Codable
extension Sign: Codable {}

// MARK: Hashable
extension Sign: Hashable {}

// MARK: Code
extension Sign.Code {
    var code: Int {
        switch self {
        case .aries:
            return 1
        case .taurus:
            return 2
        case .gemini:
            return 3
        case .cancer:
            return 4
        case .leo:
            return 5
        case .virgo:
            return 6
        case .libra:
            return 7
        case .scorpio:
            return 8
        case .sagittarius:
            return 9
        case .capricorn:
            return 10
        case .aquarius:
            return 11
        case .pisces:
            return 12
        }
    }
}
