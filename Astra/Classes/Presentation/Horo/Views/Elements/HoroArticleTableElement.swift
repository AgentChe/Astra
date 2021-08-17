//
//  HoroArticleTableElement.swift
//  Astra
//
//  Created by Andrey Chernyshev on 17.08.2021.
//

final class HoroArticleTableElement {
    let articles: [Horo]
    var isOpened: Bool
    var selectedPeriod: String
    
    init(articles: [Horo],
         isOpened: Bool,
         selectedPeriod: String) {
        self.articles = articles
        self.isOpened = isOpened
        self.selectedPeriod = selectedPeriod
    }
}
