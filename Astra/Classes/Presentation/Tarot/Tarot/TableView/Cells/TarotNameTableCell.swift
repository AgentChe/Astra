//
//  TarotNameTableCell.swift
//  Astra
//
//  Created by Andrey Chernyshev on 19.08.2021.
//

import UIKit

final class TarotNameTableCell: UITableViewCell {
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
extension TarotNameTableCell {
    func setup(name: String) {
        let attrs = TextAttributes()
            .textColor(UIColor(integralRed: 31, green: 31, blue: 31))
            .font(Fonts.Qanelas.bold(size: 24.scale))
            .lineHeight(28.6.scale)
            .textAlignment(.center)
        
        label.attributedText = name.attributed(with: attrs)
    }
}

// MARK: Private
private extension TarotNameTableCell {
    func initialize() {
        backgroundColor = UIColor.clear
        contentView.backgroundColor = UIColor.clear
        
        selectionStyle = .none
    }
}

// MARK: Make constraints
private extension TarotNameTableCell {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20.scale),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20.scale),
            label.topAnchor.constraint(equalTo: contentView.topAnchor),
            label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}

// MARK: Lazy initialization
private extension TarotNameTableCell {
    func makeLabel() -> UILabel {
        let view = UILabel()
        view.numberOfLines = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(view)
        return view
    }
}
