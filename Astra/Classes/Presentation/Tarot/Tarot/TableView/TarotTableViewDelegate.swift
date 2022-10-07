//
//  TarotTableViewDelegate.swift
//  Astra
//
//  Created by Andrey Chernyshev on 21.08.2021.
//

import CoreGraphics

protocol TarotTableViewDelegate: AnyObject {
    func taroTableViewDidSelect(imagePath: String, isReversed: Bool, in rect: CGRect)
}
