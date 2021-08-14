//
//  MainProfileCell.swift
//  Astra
//
//  Created by Andrey Chernyshev on 14.08.2021.
//

import UIKit

final class MainProfileCell: UITableViewCell {
    weak var mainDelegate: MainTableViewDelegate?
    
    lazy var nameLabel = makeLabel()
    lazy var infoLabel = makeLabel()
    lazy var signImageView = makeSignImageView()
    lazy var settingsButton = makeSettingsButton()
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

// MARK: Public
extension MainProfileCell {
    func setup(element: ProfileMainTableElement) {
        let nameAttrs = TextAttributes()
            .textColor(UIColor(integralRed: 31, green: 31, blue: 31))
            .font(Fonts.Qanelas.bold(size: 30.scale))
            .lineHeight(36.scale)
        let name = String(format: "Main.Profile.Name".localized, element.name ?? "")
        nameLabel.attributedText = name.attributed(with: nameAttrs)
        
        let infoAttrs = TextAttributes()
            .textColor(UIColor(integralRed: 255, green: 141, blue: 91))
            .font(Fonts.Qanelas.regular(size: 17.scale))
            .lineHeight(22.1.scale)
        let info = String(format: "%@, %@", element.sign?.name ?? "", element.birthDate ?? "")
        infoLabel.attributedText = info.attributed(with: infoAttrs)
        
        if let sign = element.sign {
            signImageView.image = mapImage(from: sign)
        }
    }
    
    func mapImage(from sign: Sign) -> UIImage? {
        switch sign.code {
        case .aries:
            return UIImage(named: "Main.Profile.Aries")
        case .taurus:
            return UIImage(named: "Main.Profile.Taurus")
        case .gemini:
            return UIImage(named: "Main.Profile.Gemini")
        case .cancer:
            return UIImage(named: "Main.Profile.Cancer")
        case .leo:
            return UIImage(named: "Main.Profile.Leo")
        case .virgo:
            return UIImage(named: "Main.Profile.Virgo")
        case .libra:
            return UIImage(named: "Main.Profile.Libra")
        case .scorpio:
            return UIImage(named: "Main.Profile.Scorpio")
        case .sagittarius:
            return UIImage(named: "Main.Profile.Sagittarius")
        case .capricorn:
            return UIImage(named: "Main.Profile.Capricorn")
        case .aquarius:
            return UIImage(named: "Main.Profile.Aquarius")
        case .pisces:
            return UIImage(named: "Main.Profile.Pisces")
        }
    }
    
    @objc
    func settingsTapped() {
        mainDelegate?.mainTableViewSettingsDidTapped()
    }
}

// MARK: Private
private extension MainProfileCell {
    func initialize() {
        backgroundColor = UIColor.clear
        contentView.backgroundColor = UIColor.clear
        
        selectionStyle = .none
    }
}

// MARK: Make constraints
private extension MainProfileCell {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20.scale),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -50.scale),
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor)
        ])
        
        NSLayoutConstraint.activate([
            signImageView.widthAnchor.constraint(equalToConstant: 16.scale),
            signImageView.heightAnchor.constraint(equalToConstant: 16.scale),
            signImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20.scale),
            signImageView.centerYAnchor.constraint(equalTo: infoLabel.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            infoLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 44.scale),
            infoLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -50.scale),
            infoLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8.scale),
            infoLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -25.scale)
        ])
        
        NSLayoutConstraint.activate([
            settingsButton.widthAnchor.constraint(equalToConstant: 28.scale),
            settingsButton.heightAnchor.constraint(equalToConstant: 28.scale),
            settingsButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16.scale),
            settingsButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8.scale)
        ])
        
        NSLayoutConstraint.activate([
            separator.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20.scale),
            separator.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20.scale),
            separator.heightAnchor.constraint(equalToConstant: 1.scale),
            separator.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}

// MARK: Lazy initialization
private extension MainProfileCell {
    func makeLabel() -> UILabel {
        let view = UILabel()
        view.numberOfLines = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(view)
        return view
    }
    
    func makeSignImageView() -> UIImageView {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(view)
        return view
    }
    
    func makeSettingsButton() -> UIButton {
        let view = UIButton()
        view.setImage(UIImage(named: "Main.Profile.Settings"), for: .normal)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addTarget(self, action: #selector(settingsTapped), for: .touchUpInside)
        contentView.addSubview(view)
        return view
    }
    
    func makeSeparator() -> UIView {
        let view = UIView()
        view.backgroundColor = UIColor(integralRed: 233, green: 231, blue: 228)
        view.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(view)
        return view
    }
}
