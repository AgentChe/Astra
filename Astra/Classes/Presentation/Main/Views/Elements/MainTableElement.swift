//
//  MainTableElement.swift
//  Astra
//
//  Created by Andrey Chernyshev on 14.08.2021.
//

import CoreGraphics

enum MainTableElement {
    case offset(CGFloat)
    case profile(ProfileMainTableElement)
    case title(String)
    case horoFilter([HoroFilterTableElement])
    case horoImage(String)
    case horoContent(HoroContentTableElement)
    case horoButton
    case chart(ChartMainTableElement)
    case separator
    case biorhythms(BiorhythmsTableChartElement)
    case biorhythmsButton
    case lunarCalendar([LunarCalendarDay])
    case lunarArticle(LunarArticle)
    case lunarButton
    case dailyTarot
    case tarots
}
