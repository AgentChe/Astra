//
//  CompatibilityTextTableCelll.swift
//  Astra
//
//  Created by Andrey Chernyshev on 23.08.2021.
//

import UIKit

final class CompatibilityTextTableCelll: UITableViewCell {
    lazy var label = makeLabel()
    
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
extension CompatibilityTextTableCelll {
    func setup(text: String) {
        let attrs = TextAttributes()
            .font(Fonts.Qanelas.regular(size: 17.scale))
            .lineHeight(23.8.scale)
            .textColor(UIColor(integralRed: 63, green: 63, blue: 63))
        label.attributedText = text.attributed(with: attrs)
    }
}

// MARK: Private
private extension CompatibilityTextTableCelll {
    func initialize() {
        backgroundColor = UIColor.clear
        contentView.backgroundColor = UIColor.clear
        
        selectionStyle = .none
    }
}

// MARK: Make constraints
private extension CompatibilityTextTableCelll {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16.scale),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16.scale),
            label.topAnchor.constraint(equalTo: contentView.topAnchor),
            label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}

// MARK: Lazy initialization
private extension CompatibilityTextTableCelll {
    func makeLabel() -> UILabel {
        let view = UILabel()
        view.numberOfLines = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(view)
        return view
    }
}
