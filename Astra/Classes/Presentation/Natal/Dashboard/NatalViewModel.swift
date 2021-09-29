//
//  NatalViewModel.swift
//  Astra
//
//  Created by Andrey Chernyshev on 29.09.2021.
//

import RxSwift
import RxCocoa

final class NatalViewModel {
    lazy var elements = makeElements()
    
    private lazy var natalManager = NatalManagerCore()
}

// MARK: Private
private extension NatalViewModel {
    func makeElements() -> Driver<[NatalTableElement]> {
        natalManager.obtainNatal()
            .compactMap { $0 }
            .map { natal -> [NatalTableElement] in
                var result = [NatalTableElement]()
                
                result.append(.offset(24.scale))
                
                if let imageUrl = natal.imageUrl {
                    result.append(.image(imageUrl))
                    result.append(.offset(24.scale))
                }
                
                result.append(.whatAreButton)
                result.append(.offset(24.scale))
                
                for (index, article) in natal.articles.enumerated() {
                    let element = NatalTableElement.article(article)
                    result.append(element)
                    
                    if index != (natal.articles.count - 1) {
                        result.append(.offset(12.scale))
                    }
                }
                
                return result
            }
            .asDriver(onErrorJustReturn: [])
    }
}
