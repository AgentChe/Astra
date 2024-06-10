//
//  SplashView.swift
//  Astra
//
//  Created by Andrey Chernyshev on 11.08.2021.
//

import UIKit
import Lottie

final class SplashView: UIView {
    lazy var backgroundImageView = makeBackgroundImageView()
    lazy var animationView = makeAnimationView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Make constraints
private extension SplashView {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            backgroundImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            backgroundImageView.topAnchor.constraint(equalTo: topAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
         
        NSLayoutConstraint.activate([
            animationView.centerXAnchor.constraint(equalTo: centerXAnchor),
            animationView.centerYAnchor.constraint(equalTo: centerYAnchor),
            animationView.widthAnchor.constraint(equalToConstant: 234.scale),
            animationView.heightAnchor.constraint(equalToConstant: 234.scale)
        ])
    }
}

// MARK: Lazy initialization
private extension SplashView {
    func makeBackgroundImageView() -> UIImageView {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.image = UIImage(named: "Splash.Background")
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeAnimationView() -> LottieAnimationView {
        let view = LottieAnimationView()
        view.animation = LottieAnimation.named("Splash.Animation")
        view.contentMode = .scaleAspectFill
        view.loopMode = .playOnce
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
}
