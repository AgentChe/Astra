//
//  TarotManager.swift
//  Astra
//
//  Created by Andrey Chernyshev on 19.08.2021.
//

import RxSwift

protocol TarotManager {
    func hasTarotOnToday(with type: TarotType) -> Bool
    func obtainTarot(with type: TarotType, forceUpdate: Bool) -> Single<Tarot?>
}
