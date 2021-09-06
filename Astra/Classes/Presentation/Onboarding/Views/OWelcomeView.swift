//
//  OWelcomeView.swift
//  Astra
//
//  Created by Andrey Chernyshev on 11.08.2021.
//

import UIKit

final class OWelcomeView: OSlideView {
    lazy var label = makeLabel()
    
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
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [weak self] in
            self?.onNext()
        }
    }
}

// MARK: Make constraints
private extension OWelcomeView {
    func makeConstraits() {
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: centerXAnchor),
            label.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}

// MARK: Lazy initialization
private extension OWelcomeView {
    func makeLabel() -> UILabel {
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
        view.numberOfLines = 0
        view.attributedText = string
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
}
