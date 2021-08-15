//
//  HoroContentTableElement.swift
//  Astra
//
//  Created by Andrey Chernyshev on 16.08.2021.
//

final class HoroContentTableElement {
    let horos: [Horo]
    var selectedPeriod: String
    
    init(horos: [Horo], selectedPeriod: String) {
        self.horos = horos
        self.selectedPeriod = selectedPeriod
    }
}
