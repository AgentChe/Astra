//
//  OFindMoreView.swift
//  Astra
//
//  Created by Andrey Chernyshev on 01.09.2021.
//

import UIKit

final class OFindMoreView: OSlideView {
    lazy var label = makeLabel()
    
    override init(step: OnboardingView.Step) {
        super.init(step: step)
        
        makeConstraits()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func moveToThis() {
        super.moveToThis()
        
        UIView.animate(withDuration: 1, animations: { [weak self] in
            self?.label.alpha = 1
        }, completion: { [weak self] _ in
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [weak self] in
                self?.onNext()
            }
        })
    }
}

// MARK: Make constraints
private extension OFindMoreView {
    func makeConstraits() {
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: centerXAnchor),
            label.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}

// MARK: Lazy initialization
private extension OFindMoreView {
    func makeLabel() -> UILabel {
        let attrs = TextAttributes()
            .textColor(UIColor(integralRed: 31, green: 31, blue: 31))
            .font(Fonts.Qanelas.regular(size: 24.scale))
            .lineHeight(31.2.scale)
            .textAlignment(.center)
        
        let view = UILabel()
        view.alpha = 0
        view.numberOfLines = 0
        view.attributedText = "Onboarding.FindMore.Text".localized.attributed(with: attrs)
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
}
