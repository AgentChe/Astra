//
//  HoroFilterTableElement.swift
//  Astra
//
//  Created by Andrey Chernyshev on 15.08.2021.
//

final class HoroFilterTableElement {
    let title: String
    var isSelected: Bool
    
    init(title: String, isSelected: Bool) {
        self.title = title
        self.isSelected = isSelected
    }
}
