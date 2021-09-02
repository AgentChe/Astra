//
//  PartnerSignCollectionCell.swift
//  Astra
//
//  Created by Andrey Chernyshev on 01.09.2021.
//

import UIKit

final class PartnerSignCollectionCell: UICollectionViewCell {
    lazy var iconView = makeIconView()
    
    private lazy var iconWidth = NSLayoutConstraint()
    private lazy var iconHeight = NSLayoutConstraint()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        makeConstraints()
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Public
extension PartnerSignCollectionCell {
    func setup(element: PartnerSignCollectionElement) {
        iconView.image = image(at: element.sign.code)
        iconWidth.isActive = false
        iconHeight.isActive = false
        iconWidth.constant = element.isSelected ? 261.scale : 161.scale
        iconHeight.constant = element.isSelected ? 308.scale : 190.scale
        iconWidth.isActive = true
        iconHeight.isActive = true
    }
}

// MARK: Private
private extension PartnerSignCollectionCell {
    func initialize() {
        backgroundColor = UIColor.clear
        contentView.backgroundColor = UIColor.clear
        
        let selectedView = UIView()
        selectedView.backgroundColor = UIColor.clear
        selectedBackgroundView = selectedView
    }
    
    func image(at code: Sign.Code) -> UIImage? {
        switch code {
        case .aries:
            return UIImage(named: "Onboarding.Signs.Large.Aries")
        case .taurus:
            return UIImage(named: "Onboarding.Signs.Large.Taurus")
        case .gemini:
            return UIImage(named: "Onboarding.Signs.Large.Gemini")
        case .cancer:
            return UIImage(named: "Onboarding.Signs.Large.Cancer")
        case .leo:
            return UIImage(named: "Onboarding.Signs.Large.Leo")
        case .virgo:
            return UIImage(named: "Onboarding.Signs.Large.Virgo")
        case .libra:
            return UIImage(named: "Onboarding.Signs.Large.Libra")
        case .scorpio:
            return UIImage(named: "Onboarding.Signs.Large.Scorpio")
        case .sagittarius:
            return UIImage(named: "Onboarding.Signs.Large.Saggitarius")
        case .capricorn:
            return UIImage(named: "Onboarding.Signs.Large.Capricorn")
        case .aquarius:
            return UIImage(named: "Onboarding.Signs.Large.Aquarius")
        case .pisces:
            return UIImage(named: "Onboarding.Signs.Large.Pisces")
        }
    }
}

// MARK: Make constraints
private extension PartnerSignCollectionCell {
    func makeConstraints() {
        iconWidth = iconView.widthAnchor.constraint(equalToConstant: 261.scale)
        iconHeight = iconView.heightAnchor.constraint(equalToConstant: 308.scale)
        NSLayoutConstraint.activate([
            iconWidth, iconHeight,
            iconView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            iconView.topAnchor.constraint(equalTo: contentView.topAnchor)
        ])
    }
}

// MARK: Lazy initialization
private extension PartnerSignCollectionCell {
    func makeIconView() -> UIImageView {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(view)
        return view
    }
}
