//
//  MainViewModel.swift
//  Astra
//
//  Created by Andrey Chernyshev on 13.08.2021.
//

import RxSwift
import RxCocoa

final class MainViewModel {
    lazy var elements = makeElements()
    
    private lazy var contentManager = ContentManagerCore()
}

// MARK: Private
private extension MainViewModel {
    func makeElements() -> Driver<[MainTableElement]> {
        contentManager.obtainDashboard()
            .map { dashboard -> [MainTableElement] in
                guard let dashboard = dashboard else {
                    return []
                }
                
                var result = [MainTableElement]()
                
                let profile = ProfileMainTableElement(name: dashboard.name,
                                                      sign: dashboard.sign,
                                                      birthDate: dashboard.birthdate)
                result.append(.profile(profile))
                result.append(.offset(24.scale))
                
                result.append(.title("Main.Horo.Title".localized))
                result.append(.offset(16.scale))
                
                let horoFilters = dashboard.horos.enumerated().map { index, horo -> HoroFilterTableElement in
                    HoroFilterTableElement(title: horo.period, isSelected: index == 0)
                }
                result.append(.horoFilter(horoFilters))
                result.append(.offset(17.scale))
                
                if let path = dashboard.horoImage {
                    result.append(.horoImage(path))
                }
                
                result.append(.offset(16.scale))
                
                let horoContent = HoroContentTableElement(horos: dashboard.horos,
                                                          selectedPeriod: dashboard.horos.first?.period ?? "")
                result.append(.horoContent(horoContent))
                result.append(.offset(16.scale))
                
                result.append(.horoButton)
                result.append(.offset(24.scale))
                
                result.append(.title("Main.Chart.Title".localized))
                result.append(.offset(16.scale))
                
                for (index, chart) in dashboard.charts.enumerated() {
                    let element = ChartMainTableElement(chart: chart, isOpened: index == 0)
                    result.append(.chart(element))
                    
                    if index != (dashboard.charts.count - 1) {
                        result.append(.offset(12.scale))
                    }
                }
                
                result.append(.offset(24.scale))
                result.append(.separator)
                result.append(.offset(24.scale))
                
                result.append(.title("Main.Lunar.Title".localized))
                result.append(.offset(24.scale))
                
                let lunarArticles = dashboard.lunar?.articles ?? []
                for (index, article) in lunarArticles.enumerated() {
                    result.append(.lunarArticle(article))
                    
                    if index != (dashboard.charts.count - 1) {
                        result.append(.offset(8.scale))
                    }
                }
                
                result.append(.offset(16.scale))
                result.append(.lunarButton)
                
                return result
            }
            .asDriver(onErrorJustReturn: [])
    }
}
