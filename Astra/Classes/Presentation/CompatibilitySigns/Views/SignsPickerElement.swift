//
//  SignsPickerElement.swift
//  Astra
//
//  Created by Andrey Chernyshev on 23.08.2021.
//

final class SignsPickerElement {
    let sign: Sign
    var isSelected: Bool
    
    init(sign: Sign, isSelected: Bool) {
        self.sign = sign
        self.isSelected = isSelected
    }
}
