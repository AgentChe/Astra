//
//  SettingsBuyCell.swift
//  Astra
//
//  Created by Andrey Chernyshev on 23.09.2021.
//

import UIKit

final class SettingsBuyCell: UITableViewCell {
    weak var delegate: SettingsTableViewDelegate?
    
    lazy var container = makeContainer()
    lazy var waveLeft = makeWaveLeft()
    lazy var waveRight = makeWaveRight()
    lazy var titleLabel = makeTitleLabel()
    lazy var label = makeTextLabel()
    lazy var button = makeButton()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        makeConstraints()
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Private
private extension SettingsBuyCell {
    func initialize() {
        backgroundColor = UIColor.clear
        contentView.backgroundColor = UIColor.clear
        
        selectionStyle = .none
    }
    
    @objc
    func tapped() {
        delegate?.settingsTableBuyTapped()
    }
}

// MARK: Make constraints
private extension SettingsBuyCell {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            container.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16.scale),
            container.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16.scale),
            container.topAnchor.constraint(equalTo: contentView.topAnchor),
            container.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: container.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: container.topAnchor, constant: 18.scale)
        ])
        
        NSLayoutConstraint.activate([
            waveLeft.trailingAnchor.constraint(equalTo: titleLabel.leadingAnchor, constant: -12.scale),
            waveLeft.widthAnchor.constraint(equalToConstant: 54.scale),
            waveLeft.heightAnchor.constraint(equalToConstant: 38.scale),
            waveLeft.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            waveRight.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 12.scale),
            waveRight.widthAnchor.constraint(equalToConstant: 54.scale),
            waveRight.heightAnchor.constraint(equalToConstant: 38.scale),
            waveRight.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 16.scale),
            label.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -16.scale),
            label.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 14.scale)
        ])
        
        NSLayoutConstraint.activate([
            button.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 12.scale),
            button.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -12.scale),
            button.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -16.scale),
            button.heightAnchor.constraint(equalToConstant: 51.scale)
        ])
    }
}

// MARK: Lazy initialization
private extension SettingsBuyCell {
    func makeContainer() -> UIImageView {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.image = UIImage(named: "Settings.Background1")
        view.isUserInteractionEnabled = true
        view.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(view)
        return view
    }
    
    func makeWaveLeft() -> UIImageView {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.image = UIImage(named: "Settings.Wave.Left")
        view.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(view)
        return view
    }
    
    func makeWaveRight() -> UIImageView {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.image = UIImage(named: "Settings.Wave.Right")
        view.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(view)
        return view
    }
    
    func makeTitleLabel() -> UILabel {
        let attrs = TextAttributes()
            .textColor(UIColor.white)
            .font(Fonts.Qanelas.regular(size: 17.scale))
            .lineHeight(23.8.scale)
            .textAlignment(.center)
        
        let view = UILabel()
        view.attributedText = "Settings.Premium.Title".localized.attributed(with: attrs)
        view.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(view)
        return view
    }
    
    func makeTextLabel() -> UILabel {
        let attrs = TextAttributes()
            .textColor(UIColor.white)
            .font(Fonts.Qanelas.bold(size: 17.scale))
            .lineHeight(23.8.scale)
            .textAlignment(.center)
        
        let view = UILabel()
        view.numberOfLines = 0
        view.attributedText = "Settings.Premium.Text1".localized.attributed(with: attrs)
        view.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(view)
        return view
    }
    
    func makeButton() -> UIButton {
        let attrs = TextAttributes()
            .textColor(UIColor(integralRed: 252, green: 252, blue: 252))
            .font(Fonts.Qanelas.bold(size: 18.scale))
        
        let view = UIButton()
        view.setAttributedTitle("Settings.Premium.Button".localized.attributed(with: attrs), for: .normal)
        view.backgroundColor = UIColor(integralRed: 255, green: 141, blue: 91)
        view.layer.cornerRadius = 7.scale
        view.addTarget(self, action: #selector(tapped), for: .touchUpInside)
        view.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(view)
        return view
    }
}
