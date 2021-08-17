//
//  HoroTableElement.swift
//  Astra
//
//  Created by Andrey Chernyshev on 17.08.2021.
//

enum HoroTableElement {
    case offset(CGFloat)
    case filter([HoroFilterTableElement])
    case image(String)
    case article(HoroArticleTableElement)
}
