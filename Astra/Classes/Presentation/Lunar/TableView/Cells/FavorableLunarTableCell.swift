//
//  FavorableLunarTableCell.swift
//  Astra
//
//  Created by Andrey Chernyshev on 18.08.2021.
//

import UIKit

final class FavorableLunarTableCell: UITableViewCell {
    lazy var container = makeContainer()
    lazy var typeLabel = makeLabel()
    lazy var valueLabel = makeLabel()
    
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
extension FavorableLunarTableCell {
    func setup(element: LunarFavorable) {
        typeLabel.attributedText = element
            .type
            .attributed(with: TextAttributes()
                            .textColor(UIColor.white)
                            .font(Fonts.Qanelas.bold(size: 17.scale))
                            .lineHeight(20.4.scale))
        
        valueLabel.attributedText = element
            .value
            .attributed(with: TextAttributes()
                            .textColor(UIColor.white)
                            .font(Fonts.Qanelas.regular(size: 17.scale))
                            .lineHeight(23.8.scale))
    }
}

// MARK: Private
private extension FavorableLunarTableCell {
    func initialize() {
        backgroundColor = UIColor.clear
        contentView.backgroundColor = UIColor.clear
        
        selectionStyle = .none
    }
}

// MARK: Make constraints
private extension FavorableLunarTableCell {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            container.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16.scale),
            container.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16.scale),
            container.topAnchor.constraint(equalTo: contentView.topAnchor),
            container.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            typeLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 16.scale),
            typeLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -16.scale),
            typeLabel.topAnchor.constraint(equalTo: container.topAnchor, constant: 12.scale)
        ])
        
        NSLayoutConstraint.activate([
            valueLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 16.scale),
            valueLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -16.scale),
            valueLabel.topAnchor.constraint(equalTo: typeLabel.bottomAnchor, constant: 7.scale),
            valueLabel.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -16.scale)
        ])
    }
}

// MARK: Lazy initialization
private extension FavorableLunarTableCell {
    func makeContainer() -> UIView {
        let view = UIView()
        view.backgroundColor = UIColor(integralRed: 31, green: 31, blue: 31, alpha: 0.4)
        view.layer.cornerRadius = 4.scale
        view.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(view)
        return view
    }
    
    func makeLabel() -> UILabel {
        let view = UILabel()
        view.numberOfLines = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(view)
        return view
    }
}
