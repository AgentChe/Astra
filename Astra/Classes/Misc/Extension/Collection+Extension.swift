//
//  Collection+Extension.swift
//  Astra
//
//  Created by Андрей Чернышев on 07.10.2022.
//

import Foundation

extension Collection {
    subscript(safe index: Index) -> Element? {
        indices.contains(index) ? self[index] : nil
    }
}
