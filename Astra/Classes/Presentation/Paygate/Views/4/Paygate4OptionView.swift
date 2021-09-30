//
//  Paygate4OptionView.swift
//  Astra
//
//  Created by Andrey Chernyshev on 23.09.2021.
//

import UIKit

final class Paygate4OptionView: UIView {
    var isSelected = false {
        didSet {
            changeSelection()
        }
    }
    
    var option: PaygateOption? {
        didSet {
            fill()
        }
    }
    
    lazy var backgroundView = makeBackgroundImageView()
    lazy var saveLabel = makeSaveLabel()
    lazy var titleLabel = makeLabel()
    lazy var subtitleLabel = makeLabel()
    lazy var imageView = makeImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        makeConstraints()
        fill()
        changeSelection()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Private
private extension Paygate4OptionView {
    func fill() {
        guard let option = self.option else {
            return
        }
        
        saveLabel.isHidden = option.save == nil
        
        titleLabel.attributedText = option
            .title
            .attributed(with: TextAttributes()
                            .textColor(isSelected ? UIColor.white : UIColor(integralRed: 31, green: 31, blue: 31))
                            .font(Fonts.Qanelas.regular(size: 21.scale))
                            .lineHeight(25.2.scale))
        
        let subtitleParts = option.subTitle.split(separator: "\n")
        let subtitlePart1String = String(subtitleParts.first ?? "")
        let subtitlePart1AttrsString = subtitlePart1String
            .attributed(with: TextAttributes()
                            .textColor(isSelected ? UIColor.white : UIColor(integralRed: 31, green: 31, blue: 31))
                            .font(Fonts.Qanelas.bold(size: 12.scale))
                            .lineHeight(15.scale))
        let subtitlePart2String = String(subtitleParts.last ?? "")
        let subtitlePart2AttrsString = subtitlePart2String
            .attributed(with: TextAttributes()
                            .textColor(isSelected ? UIColor.white.withAlphaComponent(0.7) : UIColor(integralRed: 31, green: 31, blue: 31, alpha: 0.7))
                            .font(Fonts.Qanelas.regular(size: 12.scale))
                            .lineHeight(17.scale))
        let subtitle = NSMutableAttributedString()
        subtitle.append(subtitlePart1AttrsString)
        subtitle.append(NSAttributedString(string: "\n"))
        subtitle.append(subtitlePart2AttrsString)
        subtitleLabel.attributedText = subtitle
        
        saveLabel.attributedText = (option.save ?? "")
            .attributed(with: TextAttributes()
                            .textColor(isSelected ? UIColor(integralRed: 31, green: 31, blue: 31) : UIColor.white)
                            .font(Fonts.Qanelas.bold(size: 13.scale))
                            .lineHeight(18.scale))
    }
    
    func changeSelection() {
        backgroundView.backgroundColor = isSelected ? UIColor(integralRed: 171, green: 165, blue: 231) : UIColor(integralRed: 252, green: 252, blue: 252)
        
        backgroundView.layer.borderWidth = isSelected ? 2.scale : 0
        backgroundView.layer.borderColor = isSelected ? UIColor.white.cgColor : UIColor.clear.cgColor
        
        titleLabel.textColor = isSelected ? UIColor.white : UIColor(integralRed: 31, green: 31, blue: 31)
        
        saveLabel.backgroundColor = isSelected ? UIColor(integralRed: 252, green: 252, blue: 252) : UIColor(integralRed: 171, green: 165, blue: 231)
        saveLabel.textColor = isSelected ? UIColor(integralRed: 31, green: 31, blue: 31) : UIColor.white
        
        let subtitleParts = option?.subTitle.split(separator: "\n")
        let subtitlePart1String = String(subtitleParts?.first ?? "")
        let subtitlePart1AttrsString = subtitlePart1String
            .attributed(with: TextAttributes()
                            .textColor(isSelected ? UIColor.white : UIColor(integralRed: 31, green: 31, blue: 31))
                            .font(Fonts.Qanelas.bold(size: 12.scale))
                            .lineHeight(15.scale))
        let subtitlePart2String = String(subtitleParts?.last ?? "")
        let subtitlePart2AttrsString = subtitlePart2String
            .attributed(with: TextAttributes()
                            .textColor(isSelected ? UIColor.white.withAlphaComponent(0.7) : UIColor(integralRed: 31, green: 31, blue: 31, alpha: 0.7))
                            .font(Fonts.Qanelas.regular(size: 12.scale))
                            .lineHeight(17.scale))
        let subtitle = NSMutableAttributedString()
        subtitle.append(subtitlePart1AttrsString)
        subtitle.append(NSAttributedString(string: "\n"))
        subtitle.append(subtitlePart2AttrsString)
        subtitleLabel.attributedText = subtitle
    }
}

// MARK: Make constraints
private extension Paygate4OptionView {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            backgroundView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: trailingAnchor),
            backgroundView.topAnchor.constraint(equalTo: topAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: ScreenSize.isIphoneXFamily ? 6.scale : 4.scale),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: ScreenSize.isIphoneXFamily ? -6.scale : -4.scale),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 17.scale)
        ])
        
        NSLayoutConstraint.activate([
            subtitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: ScreenSize.isIphoneXFamily ? 6.scale : 4.scale),
            subtitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: ScreenSize.isIphoneXFamily ? -6.scale : -4.scale),
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 7.scale)
        ])
        
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: ScreenSize.isIphoneXFamily ? 40.scale : 32.scale),
            imageView.heightAnchor.constraint(equalToConstant: ScreenSize.isIphoneXFamily ? 40.scale : 32.scale),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: ScreenSize.isIphoneXFamily ? -12.scale : -16.scale),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8.scale)
        ])
        
        NSLayoutConstraint.activate([
            saveLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            saveLabel.centerYAnchor.constraint(equalTo: topAnchor)
        ])
    }
}

// MARK: Lazy initialization
private extension Paygate4OptionView {
    func makeBackgroundImageView() -> UIView {
        let view = UIView()
        view.layer.cornerRadius = 8.scale
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeLabel() -> UILabel {
        let view = UILabel()
        view.numberOfLines = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeImageView() -> UIImageView {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeSaveLabel() -> PaddingLabel {
        let view = PaddingLabel()
        view.leftInset = 7.5.scale
        view.rightInset = 7.5.scale
        view.topInset = 1.5.scale
        view.bottomInset = 1.5.scale
        view.backgroundColor = UIColor(integralRed: 252, green: 252, blue: 252)
        view.layer.cornerRadius = 4.scale
        view.layer.masksToBounds = true
        view.isHidden = true
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
}
