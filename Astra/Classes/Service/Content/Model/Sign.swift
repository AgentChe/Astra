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
    }
    
    let code: Code
    let name: String
}

// MARK: Codable
extension Sign: Codable {}

// MARK: Hashable
extension Sign: Hashable {}
