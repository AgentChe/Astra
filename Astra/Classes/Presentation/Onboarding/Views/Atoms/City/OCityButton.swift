//
//  OCityButton.swift
//  Astra
//
//  Created by Andrey Chernyshev on 05.09.2021.
//

import UIKit

final class OCityButton: UIButton {
    enum Style {
        case next, skip
    }
    
    var style: Style = .skip {
        didSet {
            update()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        update()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Private
private extension OCityButton {
    func update() {
        switch style {
        case .next:
            backgroundColor = UIColor(integralRed: 255, green: 141, blue: 91)
            layer.cornerRadius = 7.scale
            
            let attrs = TextAttributes()
                .textColor(UIColor.white)
                .font(Fonts.Qanelas.bold(size: 18.scale))
                .textAlignment(.center)
            setAttributedTitle("Continue".localized.uppercased().attributed(with: attrs), for: .normal)
        case .skip:
            backgroundColor = UIColor.clear
            layer.cornerRadius = 0
            
            let attrs = TextAttributes()
                .textColor(UIColor(integralRed: 31, green: 31, blue: 31))
                .font(Fonts.Qanelas.regular(size: 18.scale))
                .textAlignment(.center)
            setAttributedTitle("Onboarding.Skip".localized.uppercased().attributed(with: attrs), for: .normal)
        }
    }
}
