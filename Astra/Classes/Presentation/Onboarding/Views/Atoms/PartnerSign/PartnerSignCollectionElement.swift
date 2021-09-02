//
//  PartnerSignCollectionElement.swift
//  Astra
//
//  Created by Andrey Chernyshev on 01.09.2021.
//

final class PartnerSignCollectionElement {
    let sign: Sign
    var isSelected = false
    
    init(sign: Sign, isSelected: Bool) {
        self.sign = sign
        self.isSelected = isSelected
    }
}
