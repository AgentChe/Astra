//
//  ChartMainTableElement.swift
//  Astra
//
//  Created by Andrey Chernyshev on 16.08.2021.
//

final class ChartMainTableElement {
    let chart: Chart
    var isOpened: Bool
    
    init(chart: Chart,
         isOpened: Bool) {
        self.chart = chart
        self.isOpened = isOpened
    }
}
