//
//  HoroViewModel.swift
//  Astra
//
//  Created by Andrey Chernyshev on 17.08.2021.
//

import RxSwift
import RxCocoa

final class HoroViewModel {
    lazy var didSelectPeriod = PublishRelay<String>()
    
    lazy var elements = makeElements()
    
    private lazy var contentManager = ContentManagerCore()
}

// MARK: Private
private extension HoroViewModel {
    func makeElements() -> Driver<[HoroTableElement]> {
        let horoFull = contentManager
            .obtainHoroFull()
            .asDriver(onErrorJustReturn: nil)
        
        let elements1 = horoFull
            .map { horoFull -> [HoroTableElement] in
                guard let horoFull = horoFull else {
                    return []
                }
                
                var result = [HoroTableElement]()
                
                let filters = horoFull.articles
                    .map { $0.period }
                    .enumerated()
                    .map { index, period -> HoroFilterTableElement in
                        HoroFilterTableElement(title: period, isSelected: index == 0)
                    }
                result.append(.filter(filters))
                
                result.append(.offset(16.scale))
                if let path = horoFull.image {
                    result.append(.image(path))
                }
                
                result.append(.offset(16.scale))
                
                return result
            }
        
        let elements2 = Driver
            .combineLatest(
                horoFull,
                
                didSelectPeriod
                    .asDriver(onErrorJustReturn: "")
                    .startWith("")
            )
            .map { horoFull, selectedPeriod -> [HoroTableElement] in
                guard let horoFull = horoFull else {
                    return []
                }
                
                let period = selectedPeriod.isEmpty ? (horoFull.articles.first?.period ?? "") : selectedPeriod
                
                guard let articles = horoFull.articles.first(where: { $0.period == period }) else {
                    return []
                }
                
                return articles.content.enumerated().map { index, content -> HoroTableElement in
                    let element = HoroArticleTableElement(content: content, isOpened: index == 0)
                    return .article(element)
                }
            }
        
        return Driver
            .combineLatest(elements1, elements2)
            .map { $0 + $1 }
    }
}
