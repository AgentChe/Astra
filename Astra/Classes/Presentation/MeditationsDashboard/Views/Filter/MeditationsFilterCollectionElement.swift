//
//  MeditationsFilterCollectionElement.swift
//  Astra
//
//  Created by Andrey Chernyshev on 24.08.2021.
//

final class MeditationsFilterCollectionElement {
    enum Code: Hashable {
        case all
        case courses
        case another(String)
    }
    
    let code: Code
    var isSelected: Bool
    
    init(code: Code,
         isSelected: Bool) {
        self.code = code
        self.isSelected = isSelected
    }
}
