//
//  NatalInfoView.swift
//  Astra
//
//  Created by Andrey Chernyshev on 29.09.2021.
//

import UIKit

final class NatalInfoView: UIView {
    lazy var container = makeContainer()
    lazy var closeButton = makeCloseButton()
    lazy var titleLabel = makeTitleLabel()
    lazy var textLabel = makeTextLabel()
    
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
private extension NatalInfoView {
    func initialize() {
        backgroundColor = UIColor(integralRed: 252, green: 252, blue: 252, alpha: 0.9)
    }
}

// MARK: Make constraints
private extension NatalInfoView {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            container.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16.scale),
            container.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16.scale),
            container.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            closeButton.widthAnchor.constraint(equalToConstant: 10.scale),
            closeButton.heightAnchor.constraint(equalToConstant: 10.scale),
            closeButton.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -21.scale),
            closeButton.topAnchor.constraint(equalTo: container.topAnchor, constant: 23.scale)
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 20.scale),
            titleLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -20.scale),
            titleLabel.topAnchor.constraint(equalTo: container.topAnchor, constant: 48.scale)
        ])
        
        NSLayoutConstraint.activate([
            textLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 20.scale),
            textLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -20.scale),
            textLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8.scale),
            textLabel.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -32.scale)
        ])
    }
}

// MARK: Lazy initialization
private extension NatalInfoView {
    func makeContainer() -> UIView {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.1
        view.layer.shadowOffset = .zero
        view.layer.shadowRadius = 4.scale
        view.layer.cornerRadius = 10.scale
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeCloseButton() -> TapAreaButton {
        let view = TapAreaButton()
        view.setImage(UIImage(named: "Biorhythms.Info.Close"), for: .normal)
        view.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(view)
        return view
    }
    
    func makeTitleLabel() -> UILabel {
        let attrs = TextAttributes()
            .textColor(UIColor(integralRed: 255, green: 141, blue: 91))
            .font(Fonts.Qanelas.bold(size: 17.scale))
            .lineHeight(23.8.scale)
            .textAlignment(.center)
        
        let view = UILabel()
        view.attributedText = "Natal.Info.Title".localized.attributed(with: attrs)
        view.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(view)
        return view
    }
    
    func makeTextLabel() -> UILabel {
        let attrs = TextAttributes()
            .textColor(UIColor(integralRed: 63, green: 63, blue: 63))
            .font(Fonts.Qanelas.regular(size: 17.scale))
            .lineHeight(23.8.scale)
            .textAlignment(.center)
        
        let view = UILabel()
        view.numberOfLines = 0
        view.attributedText = "Natal.Info.Text".localized.attributed(with: attrs)
        view.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(view)
        return view
    }
}
