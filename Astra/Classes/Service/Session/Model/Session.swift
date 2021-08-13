//
//  Session.swift
//  Astra
//
//  Created by Andrey Chernyshev on 13.08.2021.
//

struct Session: Codable {
    let userId: Int?
    let userToken: String?
    let activeSubscription: Bool
}

// MARK: Make
extension Session {
    init(response: ReceiptValidateResponse) {
        self.userId = response.userId
        self.userToken = response.userToken
        self.activeSubscription = response.activeSubscription
    }
}
