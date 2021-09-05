//
//  OCityView.swift
//  Astra
//
//  Created by Andrey Chernyshev on 04.09.2021.
//

import UIKit
import RxSwift

final class OCityView: OSlideView {
    lazy var titleLabel = makeTitleLabel()
    lazy var searchView = makeSearchView()
    lazy var imageView = makeImageView()
    lazy var button = makeButton()
    
    override init(step: OnboardingView.Step) {
        super.init(step: step)
        
        makeConstraits()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Private
private extension OCityView {
    
}

// MARK: Make constraints
private extension OCityView {
    func makeConstraits() {
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16.scale),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16.scale),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: ScreenSize.isIphoneXFamily ? 130.scale : 70.scale)
        ])
        
        NSLayoutConstraint.activate([
            searchView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16.scale),
            searchView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16.scale),
            searchView.heightAnchor.constraint(equalToConstant: 60.scale),
            searchView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 32.scale)
        ])
        
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: 338.scale),
            imageView.heightAnchor.constraint(equalToConstant: 270.scale),
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.topAnchor.constraint(equalTo: searchView.bottomAnchor, constant: 45.scale)
        ])
        
        NSLayoutConstraint.activate([
            button.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 26.scale),
            button.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -26.scale),
            button.heightAnchor.constraint(equalToConstant: 51.scale),
            button.bottomAnchor.constraint(equalTo: bottomAnchor, constant: ScreenSize.isIphoneXFamily ? -60.scale : -20.scale)
        ])
    }
}

// MARK: Lazy initialization
private extension OCityView {
    func makeTitleLabel() -> UILabel {
        let attrs = TextAttributes()
            .textColor(UIColor(integralRed: 31, green: 31, blue: 31))
            .font(Fonts.Qanelas.bold(size: 30.scale))
            .lineHeight(36.scale)
            .textAlignment(.center)
        
        let view = UILabel()
        view.numberOfLines = 0
        view.attributedText = "Onboarding.City.Title".localized.attributed(with: attrs)
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeSearchView() -> CitySearchView {
        let view = CitySearchView()
        view.backgroundColor = UIColor.white
        view.layer.cornerRadius = 4.scale
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeImageView() -> UIImageView {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.image = UIImage(named: "Onboarding.City.Image")
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeButton() -> OCityButton {
        let view = OCityButton()
        view.style = .skip
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
}
