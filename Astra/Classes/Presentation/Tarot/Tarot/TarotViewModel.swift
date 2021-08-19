//
//  TarotViewModel.swift
//  Astra
//
//  Created by Andrey Chernyshev on 19.08.2021.
//

import RxSwift
import RxCocoa

final class TarotViewModel {
    lazy var elements = makeElements()
    
    lazy var tarotType = BehaviorRelay<TarotType?>(value: nil)
    
    private lazy var tarotManager = TarotManagerCore()
}

// MARK: Private
private extension TarotViewModel {
    func makeElements() -> Driver<[TarotTableElement]> {
        tarotType
            .compactMap { $0 }
            .flatMapLatest { [weak self] type -> Single<Tarot?> in
                guard let self = self else {
                    return .never()
                }
                
                let hasTarot = self.tarotManager.hasTarotOnToday(with: type)
                
                return self.tarotManager
                    .obtainTarot(with: type, forceUpdate: !hasTarot)
            }
            .map { tarot -> [TarotTableElement] in
                guard let tarot = tarot else {
                    return []
                }
                
                var result = [TarotTableElement]()
                
                result.append(.offset(21.scale))
                
                if let url = URL(string: tarot.image) {
                    result.append(.image(url: url, isReserved: tarot.reversed))
                    result.append(.offset(12.scale))
                }
                
                if tarot.reversed {
                    result.append(.reversed)
                    result.append(.offset(15.scale))
                }
                
                result.append(.name(tarot.name))
                
                result.append(.offset(15.scale))
                
                result.append(.tags(tarot.tags))
                
                result.append(.offset(15.scale))
                
                result.append(.text(tarot.description))
                
                result.append(.offset(24.scale))
                
                return result
            }
            .asDriver(onErrorJustReturn: [])
    }
}
