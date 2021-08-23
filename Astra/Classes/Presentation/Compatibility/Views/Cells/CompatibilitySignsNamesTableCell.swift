//
//  CompatibilitySignsNamesTableCell.swift
//  Astra
//
//  Created by Andrey Chernyshev on 23.08.2021.
//

import UIKit

final class CompatibilitySignsNamesTableCell: UITableViewCell {
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
extension CompatibilitySignsNamesTableCell {
    func setup(code1: Sign.Code, code2: Sign.Code) {
        let attrs = TextAttributes()
            .textColor(UIColor(integralRed: 31, green: 31, blue: 31))
            .font(Fonts.Qanelas.bold(size: 17.scale))
            .lineHeight(23.8.scale)
            .textAlignment(.center)
        let string = String(format: "Compatibility.Names".localized, name(at: code1), name(at: code2))
        label.attributedText = string.attributed(with: attrs)
    }
}

// MARK: Private
private extension CompatibilitySignsNamesTableCell {
    func initialize() {
        backgroundColor = UIColor.clear
        contentView.backgroundColor = UIColor.clear
        
        selectionStyle = .none
    }
    
    func name(at code: Sign.Code) -> String {
        switch code {
        case .aries:
            return "Sign.Aries".localized
        case .taurus:
            return "Sign.Taurus".localized
        case .gemini:
            return "Sign.Gemini".localized
        case .cancer:
            return "Sign.Cancer".localized
        case .leo:
            return "Sign.Leo".localized
        case .virgo:
            return "Sign.Virgo".localized
        case .libra:
            return "Sign.Libra".localized
        case .scorpio:
            return "Sign.Scorpio".localized
        case .sagittarius:
            return "Sign.Sagittarius".localized
        case .capricorn:
            return "Sign.Capricorn".localized
        case .aquarius:
            return "Sign.Aquarius".localized
        case .pisces:
            return "Sign.Pisces".localized
        }
    }
}

// MARK: Make constraints
private extension CompatibilitySignsNamesTableCell {
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
private extension CompatibilitySignsNamesTableCell {
    func makeLabel() -> UILabel {
        let view = UILabel()
        view.numberOfLines = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(view)
        return view
    }
}
