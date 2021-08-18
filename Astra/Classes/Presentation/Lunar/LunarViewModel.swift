//
//  LunarViewModel.swift
//  Astra
//
//  Created by Andrey Chernyshev on 18.08.2021.
//

import RxSwift
import RxCocoa

final class LunarViewModel {
    lazy var elements = makeElements()
    
    private lazy var contentManager = ContentManagerCore()
}

// MARK: Private
private extension LunarViewModel {
    func makeElements() -> Driver<[LunarTableElement]> {
        contentManager.obtainLunarFull()
            .map { lunarFull -> [LunarTableElement] in
                guard let lunarFull = lunarFull else {
                    return []
                }
                
                var result = [LunarTableElement]()
                
                result.append(.lunarCalendar(lunarFull.days))
                
                result.append(.offset(16.scale))
                
                for (index, article) in lunarFull.articles.enumerated() {
                    result.append(.lunarArticle(article))
                    
                    if index != (lunarFull.articles.count - 1) {
                        result.append(.offset(8.scale))
                    }
                }
                
                result.append(.offset(24.scale))
                
                result.append(.separator)
                
                result.append(.offset(24.scale))
                
                result.append(.title("Lunar.Favorable".localized))
                
                result.append(.offset(16.scale))
                
                for (index, favorable) in lunarFull.favorables.enumerated() {
                    result.append(.favorable(favorable))
                    
                    if index != (lunarFull.favorables.count - 1) {
                        result.append(.offset(12.scale))
                    }
                }
                
                result.append(.offset(24.scale))
                
                result.append(.separator)
                
                result.append(.offset(24.scale))
                
                result.append(.title("Lunar.Unfavorable".localized))
                
                result.append(.offset(16.scale))
                
                for (index, unfavorable) in lunarFull.unfavorables.enumerated() {
                    result.append(.favorable(unfavorable))
                    
                    if index != (lunarFull.unfavorables.count - 1) {
                        result.append(.offset(12.scale))
                    }
                }
                
                result.append(.offset(24.scale))
                
                result.append(.separator)
                
                result.append(.offset(24.scale))
                
                result.append(.title("Lunar.Numbers".localized))
                
                result.append(.offset(16.scale))
                
                result.append(.numbers(lunarFull.luckyNumbers))
                
                result.append(.offset(24.scale))
                
                return result
            }
            .asDriver(onErrorJustReturn: [])
    }
}
