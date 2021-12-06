//
//  UIDeviceExtension.swift
//  Nursing
//
//  Created by Andrey Chernyshev on 16.01.2021.
//

import Foundation.NSLocale
import UIKit

extension UIDevice {
    static var deviceLanguageCode: String? {
        guard let mainPreferredLanguage = Locale.preferredLanguages.first else {
            return nil
        }
        
        return Locale(identifier: mainPreferredLanguage).languageCode
    }
    
    static var appVersion: Int? {
        guard let string = Bundle.main.infoDictionary?["CFBundleVersion"] as? String else {
            return nil
        }
        
        return Int(string)
    }
}
