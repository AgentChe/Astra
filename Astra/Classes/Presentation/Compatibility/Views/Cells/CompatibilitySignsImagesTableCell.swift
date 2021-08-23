//
//  CompatibilitySignsImagesTableCell.swift
//  Astra
//
//  Created by Andrey Chernyshev on 23.08.2021.
//

import UIKit

final class CompatibilitySignsImagesTableCell: UITableViewCell {
    lazy var sign1ImageView = makeImageView()
    lazy var plusImageView = makePlusImageView()
    lazy var sign2ImageView = makeImageView()
    
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
extension CompatibilitySignsImagesTableCell {
    func setup(code1: Sign.Code, code2: Sign.Code) {
        sign1ImageView.image = image(at: code1)
        sign2ImageView.image = image(at: code2)
    }
}

// MARK: Private
private extension CompatibilitySignsImagesTableCell {
    func initialize() {
        backgroundColor = UIColor.clear
        contentView.backgroundColor = UIColor.clear
        
        selectionStyle = .none
    }
    
    func image(at code: Sign.Code) -> UIImage? {
        switch code {
        case .aries:
            return UIImage(named: "Compatibility.Signs.Large.Aries")
        case .taurus:
            return UIImage(named: "Compatibility.Signs.Large.Taurus")
        case .gemini:
            return UIImage(named: "Compatibility.Signs.Large.Gemini")
        case .cancer:
            return UIImage(named: "Compatibility.Signs.Large.Cancer")
        case .leo:
            return UIImage(named: "Compatibility.Signs.Large.Leo")
        case .virgo:
            return UIImage(named: "Compatibility.Signs.Large.Virgo")
        case .libra:
            return UIImage(named: "Compatibility.Signs.Large.Libra")
        case .scorpio:
            return UIImage(named: "Compatibility.Signs.Large.Scorpio")
        case .sagittarius:
            return UIImage(named: "Compatibility.Signs.Large.Saggitarius")
        case .capricorn:
            return UIImage(named: "Compatibility.Signs.Large.Capricorn")
        case .aquarius:
            return UIImage(named: "Compatibility.Signs.Large.Aquarius")
        case .pisces:
            return UIImage(named: "Compatibility.Signs.Large.Pisces")
        }
    }
}

// MARK: Make constraints
private extension CompatibilitySignsImagesTableCell {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            sign1ImageView.widthAnchor.constraint(equalToConstant: 149.scale),
            sign1ImageView.heightAnchor.constraint(equalToConstant: 160.scale),
            sign1ImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            sign1ImageView.trailingAnchor.constraint(equalTo: plusImageView.leadingAnchor, constant: -11.scale)
        ])
        
        NSLayoutConstraint.activate([
            plusImageView.widthAnchor.constraint(equalToConstant: 24.scale),
            plusImageView.heightAnchor.constraint(equalToConstant: 24.scale),
            plusImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            plusImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            sign2ImageView.widthAnchor.constraint(equalToConstant: 149.scale),
            sign2ImageView.heightAnchor.constraint(equalToConstant: 160.scale),
            sign2ImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            sign2ImageView.leadingAnchor.constraint(equalTo: plusImageView.trailingAnchor, constant: 11.scale)
        ])
    }
}

// MARK: Lazy initialization
private extension CompatibilitySignsImagesTableCell {
    func makeImageView() -> UIImageView {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(view)
        return view
    }
    
    func makePlusImageView() -> UIImageView {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.image = UIImage(named: "Compatibility.Plus")
        view.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(view)
        return view
    }
}
