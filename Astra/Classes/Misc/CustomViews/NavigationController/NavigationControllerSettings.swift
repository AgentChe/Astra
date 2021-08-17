//
//  NursingNavigationControllerSettings.swift
//  Nursing
//
//  Created by Andrey Chernyshev on 16.01.2021.
//

import UIKit

struct NavigationControllerSettings {
    let backgroundImage: UIImage
    let shadowImage: UIImage
    let isTranslucent: Bool
    let tintColor: UIColor
    let titleTextAttrributes: [NSAttributedString.Key: Any]
}

// MARK: Make
extension NavigationControllerSettings {
    static func `default`() -> NavigationControllerSettings {
        NavigationControllerSettings(backgroundImage: UIImage(),
                                     shadowImage: UIImage(),
                                     isTranslucent: true,
                                     tintColor: UIColor(integralRed: 54, green: 56, blue: 83),
                                     titleTextAttrributes: TextAttributes()
                                        .textColor(UIColor(integralRed: 31, green: 31, blue: 31))
                                        .font(Fonts.Qanelas.bold(size: 24.scale))
                                        .textAlignment(.center)
                                        .dictionary)
    }
}
