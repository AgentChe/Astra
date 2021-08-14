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
                
                return []
            }
            .asDriver(onErrorJustReturn: [])
    }
}
