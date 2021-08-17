//
//  HoroArticleTableElement.swift
//  Astra
//
//  Created by Andrey Chernyshev on 17.08.2021.
//

final class HoroArticleTableElement {
    let content: HoroContent
    var isOpened: Bool
    
    init(content: HoroContent,
         isOpened: Bool) {
        self.content = content
        self.isOpened = isOpened
    }
}
