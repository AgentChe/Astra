//
//  OWelcomeView.swift
//  Astra
//
//  Created by Andrey Chernyshev on 11.08.2021.
//

import UIKit

final class OWelcomeView: OSlideView {
    lazy var label1 = makeLabel1()
    lazy var label2 = makeLabel2()
    
    override init(step: OnboardingView.Step) {
        super.init(step: step)
        
        makeConstraits()
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Private
private extension OWelcomeView {
    func initialize() {
        SDKStorage.shared
            .amplitudeManager
            .logEvent(name: "Welcome Screen", parameters: [:])
        
        UIView.animate(withDuration: 1, animations: { [weak self] in
            self?.label1.alpha = 1
        }, completion: { _ in
            UIView.animate(withDuration: 1, delay: 3, animations: { [weak self] in
                self?.label2.alpha = 1
            }, completion: { [weak self] _ in
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
                    self?.onNext()
                }
            })
        })
    }
}

// MARK: Make constraints
private extension OWelcomeView {
    func makeConstraits() {
        NSLayoutConstraint.activate([
            label1.centerXAnchor.constraint(equalTo: centerXAnchor),
            label1.topAnchor.constraint(equalTo: topAnchor, constant: ScreenSize.isIphoneXFamily ? 265.scale : 180.scale)
        ])
        
        NSLayoutConstraint.activate([
            label2.centerXAnchor.constraint(equalTo: centerXAnchor),
            label2.topAnchor.constraint(equalTo: label1.bottomAnchor)
        ])
    }
}

// MARK: Lazy initialization
private extension OWelcomeView {
    func makeLabel1() -> UILabel {
        let attrs1 = TextAttributes()
            .textColor(UIColor(integralRed: 31, green: 31, blue: 31))
            .font(Fonts.Qanelas.bold(size: 24.scale))
            .lineHeight(31.2.scale)
            .textAlignment(.center)
        
        let attrs2 = TextAttributes()
            .textColor(UIColor(integralRed: 31, green: 31, blue: 31))
            .font(Fonts.Qanelas.regular(size: 24.scale))
            .lineHeight(31.2.scale)
            .textAlignment(.center)
        
        let string = NSMutableAttributedString()
        string.append("Onboarding.Welcome.Text1".localized.attributed(with: attrs1))
        string.append("Onboarding.Welcome.Text2".localized.attributed(with: attrs2))
        
        let view = UILabel()
        view.alpha = 0
        view.numberOfLines = 0
        view.attributedText = string
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeLabel2() -> UILabel {
        let attrs = TextAttributes()
            .textColor(UIColor(integralRed: 31, green: 31, blue: 31))
            .font(Fonts.Qanelas.regular(size: 24.scale))
            .lineHeight(31.2.scale)
            .textAlignment(.center)
        
        let view = UILabel()
        view.alpha = 0
        view.numberOfLines = 0
        view.attributedText = "Onboarding.Welcome.Text3".localized.attributed(with: attrs)
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
}
