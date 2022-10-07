//
//  LunarTableElement.swift
//  Astra
//
//  Created by Andrey Chernyshev on 18.08.2021.
//

import CoreGraphics

enum LunarTableElement {
    case offset(CGFloat)
    case lunarCalendar([LunarCalendarDay])
    case lunarArticle(LunarArticle)
    case separator
    case title(String)
    case favorable(LunarFavorable)
    case numbers([Int])
}
