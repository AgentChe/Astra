//
//  SplashView.swift
//  Astra
//
//  Created by Andrey Chernyshev on 11.08.2021.
//

import UIKit

final class SplashView: UIView {
    lazy var backgroundImageView = makeBackgroundImageView()
    lazy var imageView = makeImageView()
    
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
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 234.scale),
            imageView.heightAnchor.constraint(equalToConstant: 234.scale)
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
    
    func makeImageView() -> UIImageView {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.image = UIImage(named: "Splash.Image")
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
}
