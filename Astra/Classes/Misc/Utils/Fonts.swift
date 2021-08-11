//
//  Fonts.swift
//  Nursing
//
//  Created by Andrey Chernyshev on 16.01.2021.
//

import UIKit

struct Fonts {
    // MARK: Qanelas
    struct Qanelas {
        static func bold(size: CGFloat) -> UIFont {
            UIFont(name: "Qanelas-Bold", size: size)!
        }
        
        static func regular(size: CGFloat) -> UIFont {
            UIFont(name: "Qanelas-Regular", size: size)!
        }
        
        static func semiBold(size: CGFloat) -> UIFont {
            UIFont(name: "Qanelas-Semibold", size: size)!
        }
    }
}
