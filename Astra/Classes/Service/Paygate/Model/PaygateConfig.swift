//
//  PaygateConfig.swift
//  Astra
//
//  Created by Andrey Chernyshev on 22.09.2021.
//

struct PaygateConfig {
    let variant: Int
    let afterOnboarding: Bool
    let blockEverything: Bool
    let horoscopes: Bool
    let tarotDaily: Bool
    let tarotLove: Bool
    let tarotCareer: Bool
    let tarotMoney: Bool
    let lunar: Bool
    let biorhythms: Bool
    let compatibility: Bool
}

// MARK: Codable
extension PaygateConfig: Codable {}

// MARK: Hashable
extension PaygateConfig: Hashable {}

// MARK: Make
extension PaygateConfig {
    static func `default`() -> PaygateConfig {
        PaygateConfig(variant: 1,
                      afterOnboarding: false,
                      blockEverything: false,
                      horoscopes: false,
                      tarotDaily: false,
                      tarotLove: false,
                      tarotCareer: false,
                      tarotMoney: false,
                      lunar: false,
                      biorhythms: false,
                      compatibility: false)
    }
}
