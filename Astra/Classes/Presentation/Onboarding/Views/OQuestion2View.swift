//
//  OQuestion2View.swift
//  Astra
//
//  Created by Andrey Chernyshev on 21.09.2021.
//

import UIKit

final class OQuestion2View: OSlideView {
    lazy var titleLabel = makeTitleLabel()
    lazy var questionLabel = makeQuestionLabel()
    lazy var imageView = makeImageView()
    lazy var cloudView = makeCloudView()
    lazy var yesButton = makeYesButton()
    lazy var noButton = makeNoButton()
    
    private let question: String
    
    init(step: OnboardingView.Step, question: String) {
        self.question = question
        
        super.init(step: step)
        
        makeConstraints()
        
        layer.masksToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func moveToThis() {
        super.moveToThis()
        
        SDKStorage.shared
            .amplitudeManager
            .logEvent(name: "Statement 2 Screen", parameters: [:])
    }
}

// MARK: Make constraints
private extension OQuestion2View {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16.scale),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16.scale),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: ScreenSize.isIphoneXFamily ? 130.scale : 70.scale)
        ])
        
        NSLayoutConstraint.activate([
            cloudView.leadingAnchor.constraint(equalTo: leadingAnchor),
            cloudView.widthAnchor.constraint(equalToConstant: 250.scale),
            cloudView.heightAnchor.constraint(equalToConstant: ScreenSize.isIphoneXFamily ? 239.scale : 206.scale),
            cloudView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 29.scale)
        ])
        
        NSLayoutConstraint.activate([
            questionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 34.scale),
            questionLabel.topAnchor.constraint(equalTo: cloudView.topAnchor, constant: ScreenSize.isIphoneXFamily ? 71.scale : 51.scale)
        ])
        
        NSLayoutConstraint.activate([
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 253.scale),
            imageView.heightAnchor.constraint(equalToConstant: ScreenSize.isIphoneXFamily ? 279.scale : 246.scale),
            imageView.bottomAnchor.constraint(equalTo: yesButton.topAnchor, constant: -1.scale)
        ])
        
        NSLayoutConstraint.activate([
            yesButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16.scale),
            yesButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16.scale),
            yesButton.heightAnchor.constraint(equalToConstant: 51.scale),
            yesButton.bottomAnchor.constraint(equalTo: noButton.topAnchor, constant: -8.scale)
        ])
        
        NSLayoutConstraint.activate([
            noButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16.scale),
            noButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16.scale),
            noButton.heightAnchor.constraint(equalToConstant: 51.scale),
            noButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: ScreenSize.isIphoneXFamily ? -40.scale : -20.scale)
        ])
    }
}

// MARK: Lazy initialization
private extension OQuestion2View {
    func makeTitleLabel() -> UILabel {
        let attrs = TextAttributes()
            .textColor(UIColor(integralRed: 31, green: 31, blue: 31))
            .font(Fonts.Qanelas.bold(size: 30.scale))
            .lineHeight(36.scale)
            .textAlignment(.center)
        
        let view = UILabel()
        view.numberOfLines = 0
        view.attributedText = "Onboarding.Question.Title".localized.attributed(with: attrs)
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeQuestionLabel() -> UILabel {
        let attrs = TextAttributes()
            .textColor(UIColor(integralRed: 31, green: 31, blue: 31))
            .font(Fonts.Qanelas.regular(size: 20.scale))
            .lineHeight(24.scale)
            .textAlignment(.center)
        
        let view = UILabel()
        view.attributedText = question.attributed(with: attrs)
        view.numberOfLines = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeImageView() -> UIImageView {
        let view = UIImageView()
        view.image = UIImage(named: "Onboarding.Question2")
        view.contentMode = .scaleAspectFill
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeCloudView() -> UIImageView {
        let view = UIImageView()
        view.image = UIImage(named: "Onboarding.Question.Cloud2")
        view.contentMode = .scaleAspectFill
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeYesButton() -> UIButton {
        let attrs = TextAttributes()
            .textColor(UIColor.white)
            .font(Fonts.Qanelas.bold(size: 18.scale))
            .textAlignment(.center)
        
        let view = UIButton()
        view.layer.cornerRadius = 7.scale
        view.backgroundColor = UIColor(integralRed: 255, green: 141, blue: 91)
        view.setAttributedTitle("Onboarding.Question.Yes".localized.uppercased().attributed(with: attrs), for: .normal)
        view.addTarget(self, action: #selector(onNext), for: .touchUpInside)
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeNoButton() -> UIButton {
        let attrs = TextAttributes()
            .textColor(UIColor(integralRed: 63, green: 63, blue: 63))
            .font(Fonts.Qanelas.bold(size: 18.scale))
            .textAlignment(.center)
        
        let view = UIButton()
        view.backgroundColor = UIColor.clear
        view.setAttributedTitle("Onboarding.Question.No".localized.uppercased().attributed(with: attrs), for: .normal)
        view.addTarget(self, action: #selector(onNext), for: .touchUpInside)
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
}
