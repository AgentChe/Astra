//
//  HoroContentMainTableCell.swift
//  Astra
//
//  Created by Andrey Chernyshev on 15.08.2021.
//

import UIKit

final class HoroContentMainTableCell: UITableViewCell {
    lazy var titleLabel = makeLabel()
    
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
extension HoroContentMainTableCell {
    func setup(element: HoroContentTableElement) {
        guard let content = element.horos.first(where: { $0.period == element.selectedPeriod })?.content else {
            return
        }

        let attrs1 = TextAttributes()
            .textColor(UIColor(integralRed: 63, green: 63, blue: 63))
            .font(Fonts.Qanelas.bold(size: 17.scale))
            .lineHeight(23.8.scale)

        let attrs2 = TextAttributes()
            .textColor(UIColor(integralRed: 63, green: 63, blue: 63))
            .font(Fonts.Qanelas.regular(size: 17.scale))
            .lineHeight(23.8.scale)

        let string = NSMutableAttributedString()
        string.append(String(format: "%@. ", content.type).attributed(with: attrs1))
        string.append(content.text.attributed(with: attrs2))

        titleLabel.attributedText = string
    }
}

// MARK: Private
private extension HoroContentMainTableCell {
    func initialize() {
        backgroundColor = UIColor.clear
        contentView.backgroundColor = UIColor.clear
        
        selectionStyle = .none
    }
}

// MARK: Make constraints
private extension HoroContentMainTableCell {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16.scale),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16.scale),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}

// MARK: Lazy initialization
private extension HoroContentMainTableCell {
    func makeLabel() -> UILabel {
        let view = UILabel()
        view.numberOfLines = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(view)
        return view
    }
}
