//
//  HoroFilterCellDelegate.swift
//  Astra
//
//  Created by Andrey Chernyshev on 15.08.2021.
//

protocol HoroFilterCellDelegate: AnyObject {
    func horoFilterCellDidUpdated(selectedPeriod: String)
}
