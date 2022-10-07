//
//  TarotTableElement.swift
//  Astra
//
//  Created by Andrey Chernyshev on 19.08.2021.
//

import Foundation
import CoreGraphics

enum TarotTableElement {
    case offset(CGFloat)
    case image(url: URL, isReserved: Bool)
    case reversed
    case name(String)
    case tags([String])
    case text(String)
}
