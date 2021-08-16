//
//  SeparatorMainTableCell.swift
//  Astra
//
//  Created by Andrey Chernyshev on 16.08.2021.
//

import UIKit

final class SeparatorMainTableCell: UITableViewCell {
    lazy var separator = makeSeparator()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        makeConstraints()
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Private
private extension SeparatorMainTableCell {
    func initialize() {
        backgroundColor = UIColor.clear
        contentView.backgroundColor = UIColor.clear
        
        selectionStyle = .none
    }
}

// MARK: Make constraints
private extension SeparatorMainTableCell {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            separator.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20.scale),
            separator.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20.scale),
            separator.heightAnchor.constraint(equalToConstant: 1.scale),
            separator.topAnchor.constraint(equalTo: contentView.topAnchor)
        ])
    }
}

// MARK: Lazy initialization
private extension SeparatorMainTableCell {
    func makeSeparator() -> UIView {
        let view = UIView()
        view.backgroundColor = UIColor(integralRed: 233, green: 231, blue: 228)
        view.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(view)
        return view
    }
}
