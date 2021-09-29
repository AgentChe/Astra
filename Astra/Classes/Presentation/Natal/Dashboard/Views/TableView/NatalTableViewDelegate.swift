//
//  NatalTableViewDelegate.swift
//  Astra
//
//  Created by Andrey Chernyshev on 29.09.2021.
//

protocol NatalTableViewDelegate: AnyObject {
    func natalTableDidTappedWhatAre()
    func natalTableDidTapped(article: NatalArticle)
}
