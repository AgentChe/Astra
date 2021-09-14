//
//  BiorhythmsTableComponentCell.swift
//  Astra
//
//  Created by Andrey Chernyshev on 14.09.2021.
//

import UIKit

final class BiorhythmsTableComponentCell: UITableViewCell {
    lazy var titleLabel = makeLabel()
    lazy var componentTextLabel = makeLabel()
    
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
extension BiorhythmsTableComponentCell {
    func setup(element: BiorhythmsTableComponentElement) {
        let percent = String(format: "Biorhythms.Percent".localized, element.percent)
        titleLabel.attributedText = String(format: "%@ %@", element.name, percent)
            .attributed(with: TextAttributes()
                            .textColor(UIColor(integralRed: 31, green: 31, blue: 31))
                            .font(Fonts.Qanelas.bold(size: 17.scale))
                            .lineHeight(23.8.scale))
        
        componentTextLabel.attributedText = element.text
            .attributed(with: TextAttributes()
                            .textColor(UIColor(integralRed: 63, green: 63, blue: 63))
                            .font(Fonts.Qanelas.regular(size: 17.scale))
                            .lineHeight(23.8.scale))
    }
}

// MARK: Private
private extension BiorhythmsTableComponentCell {
    func initialize() {
        backgroundColor = UIColor.clear
        contentView.backgroundColor = UIColor.clear
        
        selectionStyle = .none
    }
}

// MARK: Make constraints
private extension BiorhythmsTableComponentCell {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20.scale),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20.scale),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor)
        ])
        
        NSLayoutConstraint.activate([
            componentTextLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20.scale),
            componentTextLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20.scale),
            componentTextLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 7.scale),
            componentTextLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}

// MARK: Lazy initialization
private extension BiorhythmsTableComponentCell {
    func makeLabel() -> UILabel {
        let view = UILabel()
        view.numberOfLines = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(view)
        return view
    }
}
