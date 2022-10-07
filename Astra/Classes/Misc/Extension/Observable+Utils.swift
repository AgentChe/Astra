//
//  Observable+Utils.swift
//  Astra
//
//  Created by Андрей Чернышев on 07.10.2022.
//

import RxSwift

extension ObservableType {
    func mapToVoid() -> Observable<Void> {
        map { _ -> Void in
            Void()
        }
    }
}
