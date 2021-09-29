//
//  NatalDetailsViewModel.swift
//  Astra
//
//  Created by Andrey Chernyshev on 29.09.2021.
//

import RxSwift
import RxCocoa

final class NatalDetailsViewModel {
    lazy var article = BehaviorRelay<NatalArticle?>(value: nil)
    
    lazy var elements = makeElements()
}

// MARK: Private
private extension NatalDetailsViewModel {
    func makeElements() -> Driver<[NatalDetailsTableElement]> {
        article
            .compactMap { $0 }
            .map { article -> [NatalDetailsTableElement] in
                var result = [NatalDetailsTableElement]()
                
                result.append(.offset(18.scale))
                
                result.append(.title(article))
                result.append(.offset(16.scale))
                
                result.append(.text(article.text))
                
                return result
            }
            .asDriver(onErrorJustReturn: [])
    }
}

