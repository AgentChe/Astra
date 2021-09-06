//
//  OStepView.swift
//  FNP
//
//  Created by Andrey Chernyshev on 11.07.2021.
//

import UIKit

final class OStepView: UIView {
    lazy var count = 0 {
        didSet {
            createViews()
        }
    }
    
    lazy var step = 0 {
        didSet {
            fillViews()
        }
    }
    
    lazy var showSkip: Bool = false {
        didSet {
            createViews()
            fillViews()
            updateSkipButton()
        }
    }
    
    lazy var views = [UIView]()
    lazy var skipButton: TapAreaButton = {
        let attrs = TextAttributes()
            .textColor(UIColor(integralRed: 31, green: 31, blue: 31))
            .font(Fonts.Qanelas.regular(size: 17.scale))
        
        let view = TapAreaButton()
        view.backgroundColor = UIColor.clear
        view.setAttributedTitle("Onboarding.Skip".localized.attributed(with: attrs), for: .normal)
        view.sizeToFit()
        addSubview(view)
        return view
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        createViews()
        fillViews()
        updateSkipButton()
    }
}

// MARK: Private
private extension OStepView {
    func createViews() {
        views.forEach { $0.removeFromSuperview() }
        views = []

        let skipMargin = 20.scale
        let skipFilling = skipMargin + skipButton.frame.width
        let skipWidth = showSkip ? skipFilling : 0
        
        let margin = 4.scale
        let totalMargin = margin * CGFloat((count - 1))

        let totalWidth = frame.width - totalMargin - skipWidth
        let width = totalWidth / CGFloat(count)

        var x = CGFloat(0)

        for _ in 0...count - 1 {
            let view = UIView()
            view.frame.size = CGSize(width: width, height: 2.scale)
            view.frame.origin = CGPoint(x: x, y: 11.scale)
            view.layer.cornerRadius = 1.scale
            addSubview(view)

            views.append(view)

            x += width + margin
        }
    }
    
    func fillViews() {
        views.forEach {
            $0.backgroundColor = UIColor.white
        }
        
        views.prefix(step).forEach {
            $0.backgroundColor = UIColor(integralRed: 255, green: 141, blue: 91)
        }
    }
    
    func updateSkipButton() {
        skipButton.isHidden = !showSkip
        
        skipButton.frame.origin = CGPoint(x: frame.width - skipButton.frame.width,
                                          y: (frame.height - skipButton.frame.height) / 2)
    }
}
