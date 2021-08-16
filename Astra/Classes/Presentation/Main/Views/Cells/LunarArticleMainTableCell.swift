//
//  LunarArticleMainTableCell.swift
//  Astra
//
//  Created by Andrey Chernyshev on 16.08.2021.
//

import UIKit

final class LunarArticleMainTableCell: UITableViewCell {
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
extension LunarArticleMainTableCell {
    func setup(element: LunarArticle) {
        let label = String(format: "%@:  ", element.label)
            .attributed(with: TextAttributes()
                            .textColor(UIColor(integralRed: 31, green: 31, blue: 31))
                            .font(Fonts.Qanelas.bold(size: 17.scale))
                            .lineHeight(23.8.scale))
        
        let value = element.value
            .attributed(with: TextAttributes()
                            .textColor(UIColor(integralRed: 63, green: 63, blue: 63))
                            .font(Fonts.Qanelas.regular(size: 17.scale))
                            .lineHeight(23.8.scale))
        
        let string = NSMutableAttributedString()
        string.append(label)
        string.append(value)
        
        titleLabel.attributedText = string
    }
}

// MARK: Private
private extension LunarArticleMainTableCell {
    func initialize() {
        backgroundColor = UIColor.clear
        contentView.backgroundColor = UIColor.clear
        
        selectionStyle = .none
    }
}

// MARK: Make constraints
private extension LunarArticleMainTableCell {
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
private extension LunarArticleMainTableCell {
    func makeLabel() -> UILabel {
        let view = UILabel()
        view.numberOfLines = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(view)
        return view
    }
}
