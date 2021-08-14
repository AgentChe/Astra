//
//  ProfileMainTableElement.swift
//  Astra
//
//  Created by Andrey Chernyshev on 14.08.2021.
//

final class ProfileMainTableElement {
    let name: String?
    let sign: Sign?
    let birthDate: String?
    
    init(name: String?,
         sign: Sign?,
         birthDate: String?) {
        self.name = name
        self.sign = sign
        self.birthDate = birthDate
    }
}
