//
//  OEnjoyingCell.swift
//  Astra
//
//  Created by Andrey Chernyshev on 12.08.2021.
//

import UIKit

final class OEnjoyingCell: UIView {
    var isSelected = false {
        didSet {
            backgroundColor = isSelected ? UIColor(integralRed: 132, green: 214, blue: 218) : UIColor.white
            titleLabel.textColor = isSelected ? UIColor.white : UIColor(integralRed: 31, green: 31, blue: 31)
        }
    }
    
    lazy var titleLabel = makeLabel()
    
    var title: String = "" {
        didSet {
            let attrs = TextAttributes()
                .textColor(UIColor(integralRed: 31, green: 31, blue: 31))
                .font(Fonts.Qanelas.regular(size: 20.scale))
                .lineHeight(28.scale)
            titleLabel.attributedText = title.attributed(with: attrs)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        makeConstraints()
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Private
private extension OEnjoyingCell {
    func initialize() {
        backgroundColor = UIColor.white
    }
}

// MARK: Make constraints
private extension OEnjoyingCell {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12.scale),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}

// MARK: Lazy initialization
private extension OEnjoyingCell {
    func makeLabel() -> UILabel {
        let view = UILabel()
        view.numberOfLines = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
}
