//
//  CompatibilityTableElement.swift
//  Astra
//
//  Created by Andrey Chernyshev on 23.08.2021.
//

enum CompatibilityTableElement {
    case offset(CGFloat)
    case images(Sign.Code, Sign.Code)
    case names(Sign.Code, Sign.Code)
    case values(CompatibilityValuesTableElement)
    case text(String)
}
