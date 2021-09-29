//
//  OPreloaderView.swift
//  Astra
//
//  Created by Andrey Chernyshev on 04.09.2021.
//

import UIKit
import Lottie

final class OPreloaderView: OSlideView {
    lazy var preloader = makePreloader()
    lazy var subtitleLabel = makeSubtitleLabel()
    lazy var animationView = makeAnimationView()
    lazy var infoLabel = makeLabel()
    
    private var timer: Timer?
    
    override init(step: OnboardingView.Step) {
        super.init(step: step)
        
        makeConstraints()
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func moveToThis() {
        super.moveToThis()
        
        SDKStorage.shared
            .amplitudeManager
            .logEvent(name: "Plan Preparation Screen", parameters: [:])
        
        animationView.play()
        calculatePercent()
    }
}

// MARK: Private
private extension OPreloaderView {
    func initialize() {
        backgroundColor = UIColor(integralRed: 255, green: 141, blue: 91)
    }
    
    func calculatePercent() {
        let attrs = TextAttributes()
            .textColor(UIColor.white)
            .font(Fonts.Qanelas.bold(size: 30.scale))
            .lineHeight(36.scale)
            .textAlignment(.center)
        
        let duration = Double(7)
        var seconds = Double(0)
        
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { [weak self] timer in
            seconds += 0.1
            
            var percent = Int(seconds / duration * 100)
            if percent > 100 {
                percent = 100
            }
            
            if percent <= 25 {
                self?.infoLabel.attributedText = "Onboarding.Preloader.Info1".localized.attributed(with: attrs)
            } else if percent <= 50 {
                self?.infoLabel.attributedText = "Onboarding.Preloader.Info2".localized.attributed(with: attrs)
            } else if percent <= 75 {
                self?.infoLabel.attributedText = "Onboarding.Preloader.Info3".localized.attributed(with: attrs)
            } else {
                self?.infoLabel.attributedText = "Onboarding.Preloader.Info4".localized.attributed(with: attrs)
            }
            
            if seconds >= duration {
                timer.invalidate()
                
                self?.finish()
            }
        }
    }
    
    func finish() {
        timer = nil
        
        animationView.stop()
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) { [weak self] in
            self?.onNext()
        }
    }
}

// MARK: Make constraints
private extension OPreloaderView {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            preloader.centerXAnchor.constraint(equalTo: centerXAnchor),
            preloader.widthAnchor.constraint(equalToConstant: 20.scale),
            preloader.heightAnchor.constraint(equalToConstant: 20.scale),
            preloader.topAnchor.constraint(equalTo: topAnchor, constant: ScreenSize.isIphoneXFamily ? 94.scale : 30.scale)
        ])
        
        NSLayoutConstraint.activate([
            subtitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16.scale),
            subtitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16.scale),
            subtitleLabel.topAnchor.constraint(equalTo: preloader.bottomAnchor, constant: 16.scale)
        ])
        
        NSLayoutConstraint.activate([
            animationView.leadingAnchor.constraint(equalTo: leadingAnchor),
            animationView.trailingAnchor.constraint(equalTo: trailingAnchor),
            animationView.heightAnchor.constraint(equalToConstant: 212.scale),
            animationView.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: ScreenSize.isIphoneXFamily ? 115.scale : 60.scale)
        ])
        
        NSLayoutConstraint.activate([
            infoLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24.scale),
            infoLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24.scale),
            infoLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: ScreenSize.isIphoneXFamily ? -137.scale : -80.scale)
        ])
    }
}

// MARK: Lazy initialization
private extension OPreloaderView {
    func makePreloader() -> UIActivityIndicatorView {
        let view = UIActivityIndicatorView()
        view.startAnimating()
        view.style = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeSubtitleLabel() -> UILabel {
        let attrs = TextAttributes()
            .textColor(UIColor.white)
            .font(Fonts.Qanelas.regular(size: 17.scale))
            .lineHeight(23.8.scale)
            .textAlignment(.center)
        
        let view = UILabel()
        view.numberOfLines = 0
        view.attributedText = "Onboarding.Preloader.Subtitle".localized.attributed(with: attrs)
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeAnimationView() -> AnimationView {
        let view = AnimationView()
        view.animation = Animation.named("Onboarding.Preloader")
        view.contentMode = .scaleAspectFill
        view.loopMode = .loop
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeLabel() -> UILabel {
        let view = UILabel()
        view.numberOfLines = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
}
