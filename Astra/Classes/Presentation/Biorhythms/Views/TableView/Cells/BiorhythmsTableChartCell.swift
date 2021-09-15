//
//  BiorhythmsTableChartCell.swift
//  Astra
//
//  Created by Andrey Chernyshev on 14.09.2021.
//

import UIKit

final class BiorhythmsTableChartCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        makeConstraints()
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Public
extension BiorhythmsTableChartCell {
    func setup(element: BiorhythmsTableChartElement) {
        
    }
}

// MARK: Private
private extension BiorhythmsTableChartCell {
    func initialize() {
        backgroundColor = UIColor.clear
        contentView.backgroundColor = UIColor.clear
        
        selectionStyle = .none
    }
}

// MARK: Make constraints
private extension BiorhythmsTableChartCell {
    func makeConstraints() {
        
    }
}

// MARK: Lazy initialization
private extension BiorhythmsTableChartCell {
    
}
