//
//  HoroViewModel.swift
//  Astra
//
//  Created by Andrey Chernyshev on 17.08.2021.
//

import RxSwift
import RxCocoa

final class HoroViewModel {
    lazy var elements = makeElements()
    
    private lazy var contentManager = ContentManagerCore()
}

// MARK: Private
private extension HoroViewModel {
    func makeElements() -> Driver<[HoroTableElement]> {
        contentManager
            .obtainHoroFull()
            .map { horoFull -> [HoroTableElement] in
                guard let horoFull = horoFull else {
                    return []
                }
                
                var result = [HoroTableElement]()
                
                var filters = [HoroFilterTableElement]()
                for (index, horo) in horoFull.horos.enumerated() {
                    guard !filters.contains(where: { $0.title == horo.period }) else {
                        continue
                    }
                    
                    let filter = HoroFilterTableElement(title: horo.period, isSelected: index == 0)
                    
                    filters.append(filter)
                }
                result.append(.filter(filters))
                
                result.append(.offset(16.scale))
                if let path = horoFull.image {
                    result.append(.image(path))
                }
                
                result.append(.offset(16.scale))
                
                for index in 0...(horoFull.horos.count - 1) {
                    let element = HoroArticleTableElement(articles: horoFull.horos,
                                                          isOpened: index == 0,
                                                          selectedPeriod: horoFull.horos.first?.period ?? "")
                    
                    result.append(.article(element))
                    
                    if index != (horoFull.horos.count - 1) {
                        result.append(.offset(12.scale))
                    }
                }
                
                result.append(.offset(16.scale))
                
                return result
            }
            .asDriver(onErrorJustReturn: [])
    }
}
