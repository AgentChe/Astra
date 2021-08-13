//
//  SessionManager.swift
//  Astra
//
//  Created by Andrey Chernyshev on 13.08.2021.
//

import RxCocoa

protocol SessionManager: AnyObject {
    // MARK: API
    func store(session: Session)
    func set(userToken: String)
    func getSession() -> Session?
}
