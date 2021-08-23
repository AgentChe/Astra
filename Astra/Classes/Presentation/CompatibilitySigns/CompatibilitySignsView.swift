//
//  CompatibilitySignsView.swift
//  Astra
//
//  Created by Andrey Chernyshev on 22.08.2021.
//

import UIKit

final class CompatibilitySignsView: UIView {
    lazy var headerContainerView = makeHeaderContainer()
    lazy var headerImageView = makeHeaderImageView()
    lazy var headerLabel = makeHeaderLabel()
    lazy var signsContainerView = makeSignsContainer()
    lazy var signsTitleLabel = makeSignsTitleLabel()
    lazy var signsSubTitleLabel = makeSignsSubTitleLabel()
    lazy var signs1PickerView = makeSignsPickerView()
    lazy var separator = makeSeparator()
    lazy var signs2PickerView = makeSignsPickerView()
    lazy var button = makeButton()
    
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
private extension CompatibilitySignsView {
    func initialize() {
        backgroundColor = UIColor(integralRed: 252, green: 252, blue: 252)
    }
}

// MARK: Make constraints
private extension CompatibilitySignsView {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            headerContainerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16.scale),
            headerContainerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16.scale),
            headerContainerView.heightAnchor.constraint(equalToConstant: ScreenSize.isIphoneXFamily ? 203.scale : 190.scale),
            headerContainerView.centerXAnchor.constraint(equalTo: centerXAnchor),
            headerContainerView.topAnchor.constraint(equalTo: topAnchor, constant: ScreenSize.isIphoneXFamily ? 120.scale : 60.scale)
        ])
        
        NSLayoutConstraint.activate([
            headerImageView.leadingAnchor.constraint(equalTo: headerContainerView.leadingAnchor),
            headerImageView.trailingAnchor.constraint(equalTo: headerContainerView.trailingAnchor),
            headerImageView.heightAnchor.constraint(equalToConstant: ScreenSize.isIphoneXFamily ? 163.scale : 140.scale),
            headerImageView.topAnchor.constraint(equalTo: headerContainerView.topAnchor)
        ])
        
        NSLayoutConstraint.activate([
            headerLabel.leadingAnchor.constraint(equalTo: headerContainerView.leadingAnchor, constant: 12.scale),
            headerLabel.trailingAnchor.constraint(equalTo: headerContainerView.trailingAnchor, constant: -12.scale),
            headerLabel.topAnchor.constraint(equalTo: headerImageView.bottomAnchor, constant: 8.scale)
        ])
        
        NSLayoutConstraint.activate([
            signsContainerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            signsContainerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            signsContainerView.topAnchor.constraint(equalTo: headerContainerView.bottomAnchor, constant: 15.scale),
            signsContainerView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            signsTitleLabel.leadingAnchor.constraint(equalTo: signsContainerView.leadingAnchor, constant: 30.scale),
            signsTitleLabel.trailingAnchor.constraint(equalTo: signsContainerView.trailingAnchor, constant: -30.scale),
            signsTitleLabel.topAnchor.constraint(equalTo: signsContainerView.topAnchor, constant: ScreenSize.isIphoneXFamily ? 12.scale : 6.scale)
        ])
        
        NSLayoutConstraint.activate([
            signsSubTitleLabel.leadingAnchor.constraint(equalTo: signsContainerView.leadingAnchor, constant: 30.scale),
            signsSubTitleLabel.trailingAnchor.constraint(equalTo: signsContainerView.trailingAnchor, constant: -30.scale),
            signsSubTitleLabel.topAnchor.constraint(equalTo: signsTitleLabel.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            signs1PickerView.leadingAnchor.constraint(equalTo: signsContainerView.leadingAnchor),
            signs1PickerView.trailingAnchor.constraint(equalTo: signsContainerView.trailingAnchor),
            signs1PickerView.heightAnchor.constraint(equalToConstant: 82.scale),
            signs1PickerView.topAnchor.constraint(equalTo: signsSubTitleLabel.bottomAnchor, constant: ScreenSize.isIphoneXFamily ? 32.scale : 16.scale)
        ])
        
        NSLayoutConstraint.activate([
            separator.leadingAnchor.constraint(equalTo: signsContainerView.leadingAnchor, constant: 54.scale),
            separator.trailingAnchor.constraint(equalTo: signsContainerView.trailingAnchor, constant: -54.scale),
            separator.heightAnchor.constraint(equalToConstant: 1.scale),
            separator.topAnchor.constraint(equalTo: signs1PickerView.bottomAnchor, constant: ScreenSize.isIphoneXFamily ? 24.scale : 8.scale)
        ])
        
        NSLayoutConstraint.activate([
            signs2PickerView.leadingAnchor.constraint(equalTo: signsContainerView.leadingAnchor),
            signs2PickerView.trailingAnchor.constraint(equalTo: signsContainerView.trailingAnchor),
            signs2PickerView.heightAnchor.constraint(equalToConstant: 82.scale),
            signs2PickerView.topAnchor.constraint(equalTo: separator.bottomAnchor, constant: ScreenSize.isIphoneXFamily ? 24.scale : 8.scale)
        ])
        
        NSLayoutConstraint.activate([
            button.leadingAnchor.constraint(equalTo: signsContainerView.leadingAnchor, constant: 27.scale),
            button.trailingAnchor.constraint(equalTo: signsContainerView.trailingAnchor, constant: -27.scale),
            button.heightAnchor.constraint(equalToConstant: 51.scale),
            button.bottomAnchor.constraint(equalTo: signsContainerView.bottomAnchor, constant: -10.scale)
        ])
    }
}

// MARK: Lazy initialization
private extension CompatibilitySignsView {
    func makeHeaderContainer() -> UIView {
        let view = UIView()
        view.backgroundColor = UIColor(integralRed: 252, green: 252, blue: 252)
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.1
        view.layer.shadowOffset = .zero
        view.layer.shadowRadius = 4.scale
        view.layer.cornerRadius = 7.scale
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeHeaderImageView() -> UIImageView {
        let view = UIImageView()
        view.clipsToBounds = true
        view.layer.cornerRadius = 7.scale
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.contentMode = .scaleAspectFill
        view.image = UIImage(named: "Compatibility.Image")
        view.translatesAutoresizingMaskIntoConstraints = false
        headerContainerView.addSubview(view)
        return view
    }
    
    func makeHeaderLabel() -> UILabel {
        let attrs = TextAttributes()
            .textColor(UIColor(integralRed: 31, green: 31, blue: 31))
            .font(Fonts.Qanelas.regular(size: 17.scale))
            .lineHeight(20.4.scale)
        
        let view = UILabel()
        view.attributedText = "CompatibilitySigns.Header".localized.attributed(with: attrs)
        view.translatesAutoresizingMaskIntoConstraints = false
        headerContainerView.addSubview(view)
        return view
    }
    
    func makeSignsContainer() -> UIView {
        let view = UIView()
        view.backgroundColor = UIColor(integralRed: 252, green: 252, blue: 252)
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.1
        view.layer.shadowOffset = .zero
        view.layer.shadowRadius = 4.scale
        view.layer.cornerRadius = 7.scale
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeSignsTitleLabel() -> UILabel {
        let attrs = TextAttributes()
            .textColor(UIColor(integralRed: 63, green: 63, blue: 63))
            .font(Fonts.Qanelas.regular(size: 17.scale))
            .lineHeight(23.8.scale)
        
        let view = UILabel()
        view.attributedText = "CompatibilitySigns.Choose".localized.attributed(with: attrs)
        view.translatesAutoresizingMaskIntoConstraints = false
        signsContainerView.addSubview(view)
        return view
    }
    
    func makeSignsSubTitleLabel() -> UILabel {
        let attrs = TextAttributes()
            .textColor(UIColor(integralRed: 31, green: 31, blue: 31))
            .font(Fonts.Qanelas.bold(size: 24.scale))
            .lineHeight(28.8.scale)
        
        let view = UILabel()
        view.attributedText = "CompatibilitySigns.Compare".localized.attributed(with: attrs)
        view.translatesAutoresizingMaskIntoConstraints = false
        signsContainerView.addSubview(view)
        return view
    }
    
    func makeSignsPickerView() -> SignsPickerView {
        let view = SignsPickerView(frame: .zero)
        view.backgroundColor = UIColor.clear
        view.translatesAutoresizingMaskIntoConstraints = false
        signsContainerView.addSubview(view)
        return view
    }
    
    func makeSeparator() -> UIView {
        let view = UIView()
        view.backgroundColor = UIColor(integralRed: 233, green: 231, blue: 228)
        view.translatesAutoresizingMaskIntoConstraints = false
        signsContainerView.addSubview(view)
        return view
    }
    
    func makeButton() -> UIButton {
        let attrs = TextAttributes()
            .textColor(UIColor(integralRed: 252, green: 252, blue: 252))
            .font(Fonts.Qanelas.bold(size: 18.scale))
        
        let view = UIButton()
        view.backgroundColor = UIColor(integralRed: 255, green: 141, blue: 91)
        view.layer.cornerRadius = 7.scale
        view.setAttributedTitle("CompatibilitySigns.Check".localized.attributed(with: attrs), for: .normal)
        view.translatesAutoresizingMaskIntoConstraints = false
        signsContainerView.addSubview(view)
        return view
    }
}
