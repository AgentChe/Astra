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
                
                var horoFilters = [HoroFilterTableElement]()
                dashboard.horos.enumerated().forEach { index, horo in
                    horoFilters.append(.init(title: horo.period, isSelected: index == 0))
                }
                result.append(.horoFilter(horoFilters))
                
                return result
            }
            .asDriver(onErrorJustReturn: [])
    }
}
