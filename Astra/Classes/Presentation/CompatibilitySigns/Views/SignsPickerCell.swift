//
//  SignsPickerCell.swift
//  Astra
//
//  Created by Andrey Chernyshev on 23.08.2021.
//

import UIKit

final class SignsPickerCell: UICollectionViewCell {
    lazy var iconView = makeIconView()
    lazy var nameLabel = makeLabel()
    
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
extension SignsPickerCell {
    static func calculateWidth(element: SignsPickerElement) -> CGFloat {
        let attrs = TextAttributes()
            .textColor(element.isSelected ? UIColor(integralRed: 31, green: 31, blue: 31) : UIColor(integralRed: 63, green: 63, blue: 63))
            .font(element.isSelected ? Fonts.Qanelas.bold(size: 14.scale) : Fonts.Qanelas.regular(size: 14.scale))
            .lineHeight(19.6.scale)
        let string = element.sign.name.attributed(with: attrs)
        return string.size().width
    }
    
    func setup(element: SignsPickerElement) {
        iconView.image = image(at: element.sign.code)
        iconWidth.isActive = false
        iconHeight.isActive = false
        iconWidth.constant = element.isSelected ? 60.scale : 48.scale
        iconHeight.constant = element.isSelected ? 60.scale : 48.scale
        iconWidth.isActive = true
        iconHeight.isActive = true
        
        let attrs = TextAttributes()
            .textColor(element.isSelected ? UIColor(integralRed: 31, green: 31, blue: 31) : UIColor(integralRed: 63, green: 63, blue: 63))
            .font(element.isSelected ? Fonts.Qanelas.bold(size: 14.scale) : Fonts.Qanelas.regular(size: 14.scale))
            .lineHeight(19.6.scale)
            .textAlignment(.center)
        nameLabel.attributedText = element.sign.name.attributed(with: attrs)
    }
}

// MARK: Private
private extension SignsPickerCell {
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
            return UIImage(named: "Compatibility.Signs.Aries")
        case .taurus:
            return UIImage(named: "Compatibility.Signs.Taurus")
        case .gemini:
            return UIImage(named: "Compatibility.Signs.Gemini")
        case .cancer:
            return UIImage(named: "Compatibility.Signs.Cancer")
        case .leo:
            return UIImage(named: "Compatibility.Signs.Leo")
        case .virgo:
            return UIImage(named: "Compatibility.Signs.Virgo")
        case .libra:
            return UIImage(named: "Compatibility.Signs.Libra")
        case .scorpio:
            return UIImage(named: "Compatibility.Signs.Scorpio")
        case .sagittarius:
            return UIImage(named: "Compatibility.Signs.Saggitarius")
        case .capricorn:
            return UIImage(named: "Compatibility.Signs.Capricorn")
        case .aquarius:
            return UIImage(named: "Compatibility.Signs.Aquarius")
        case .pisces:
            return UIImage(named: "Compatibility.Signs.Pisces")
        }
    }
}

// MARK: Make constraints
private extension SignsPickerCell {
    func makeConstraints() {
        iconWidth = iconView.widthAnchor.constraint(equalToConstant: 48.scale)
        iconHeight = iconView.heightAnchor.constraint(equalToConstant: 48.scale)
        NSLayoutConstraint.activate([
            iconWidth, iconHeight,
            iconView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            iconView.topAnchor.constraint(equalTo: contentView.topAnchor)
        ])
        
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            nameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}

// MARK: Lazy initialization
private extension SignsPickerCell {
    func makeIconView() -> UIImageView {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(view)
        return view
    }
    
    func makeLabel() -> UILabel {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(view)
        return view
    }
}
