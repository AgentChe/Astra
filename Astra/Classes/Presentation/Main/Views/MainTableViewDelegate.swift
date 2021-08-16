//
//  MainTableViewDelegate.swift
//  Astra
//
//  Created by Andrey Chernyshev on 14.08.2021.
//

protocol MainTableViewDelegate: AnyObject {
    func mainTableViewSettingsDidTapped()
    func mainTableViewHoroDidTapped()
    func mainTableViewLunarDidTapped()
    func mainTableViewTarotDidTapped(code: Int)
}
