//
//  Single+Utils.swift
//  Astra
//
//  Created by Андрей Чернышев on 07.10.2022.
//

import RxSwift

extension PrimitiveSequenceType where Trait == SingleTrait {
    func mapToVoid() -> Single<Void> {
        map { _ -> Void in
            Void()
        }
    }
}
