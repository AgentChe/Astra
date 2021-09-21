//
//  OSignView.swift
//  Astra
//
//  Created by Andrey Chernyshev on 01.09.2021.
//

import UIKit
import RxSwift

final class OSignView: OSlideView {
    lazy var titleLabel = makeLabel()
    lazy var signImageView = makeSignImageView()
    lazy var textLabel = makeLabel()
    lazy var button = makeButton()
    
    private lazy var contentManager = ContentManagerCore()
    
    private var selectedGender: Gender?
    
    private lazy var disposeBag = DisposeBag()
    
    override init(step: OnboardingView.Step) {
        super.init(step: step)
        
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func moveToThis() {
        super.moveToThis()
        
        contentManager.obtainZodiacQuote()
            .asDriver(onErrorJustReturn: "")
            .drive(onNext: { [weak self] quote in
                guard let self = self, let quote = quote else {
                    return
                }
                
                self.textLabel.attributedText = quote
                    .attributed(with: TextAttributes()
                                    .textColor(UIColor(integralRed: 31, green: 31, blue: 31))
                                    .font(Fonts.Qanelas.regular(size: 24.scale))
                                    .lineHeight(31.2.scale)
                                    .textAlignment(.center))
            })
            .disposed(by: disposeBag)
    }
}

// MARK: OBirthdateViewDelegate
extension OSignView: OBirthdateViewDelegate {
    func birthdateViewChange(date: Date) {
        guard let code = contentManager.signDate(at: date)?.code else {
            return
        }
        
        titleLabel.attributedText = String(format: "Onboarding.Sign.Title".localized, name(at: code))
            .attributed(with: TextAttributes()
                            .textColor(UIColor(integralRed: 31, green: 31, blue: 31))
                            .font(Fonts.Qanelas.bold(size: 30.scale))
                            .lineHeight(36.scale)
                            .textAlignment(.center))
        
        signImageView.image = image(at: code)
    }
}

// MARK: Private
private extension OSignView {
    func name(at code: Sign.Code) -> String {
        switch code {
        case .aries:
            return "Sign.Aries".localized
        case .taurus:
            return "Sign.Taurus".localized
        case .gemini:
            return "Sign.Gemini".localized
        case .cancer:
            return "Sign.Cancer".localized
        case .leo:
            return "Sign.Leo".localized
        case .virgo:
            return "Sign.Virgo".localized
        case .libra:
            return "Sign.Libra".localized
        case .scorpio:
            return "Sign.Scorpio".localized
        case .sagittarius:
            return "Sign.Sagittarius".localized
        case .capricorn:
            return "Sign.Capricorn".localized
        case .aquarius:
            return "Sign.Aquarius".localized
        case .pisces:
            return "Sign.Pisces".localized
        }
    }
    
    func image(at code: Sign.Code) -> UIImage? {
        switch code {
        case .aries:
            return UIImage(named: "Onboarding.Signs.Large.Aries")
        case .taurus:
            return UIImage(named: "Onboarding.Signs.Large.Taurus")
        case .gemini:
            return UIImage(named: "Onboarding.Signs.Large.Gemini")
        case .cancer:
            return UIImage(named: "Onboarding.Signs.Large.Cancer")
        case .leo:
            return UIImage(named: "Onboarding.Signs.Large.Leo")
        case .virgo:
            return UIImage(named: "Onboarding.Signs.Large.Virgo")
        case .libra:
            return UIImage(named: "Onboarding.Signs.Large.Libra")
        case .scorpio:
            return UIImage(named: "Onboarding.Signs.Large.Scorpio")
        case .sagittarius:
            return UIImage(named: "Onboarding.Signs.Large.Saggitarius")
        case .capricorn:
            return UIImage(named: "Onboarding.Signs.Large.Capricorn")
        case .aquarius:
            return UIImage(named: "Onboarding.Signs.Large.Aquarius")
        case .pisces:
            return UIImage(named: "Onboarding.Signs.Large.Pisces")
        }
    }
}

// MARK: Make constraints
private extension OSignView {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16.scale),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16.scale),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: ScreenSize.isIphoneXFamily ? 130.scale : 70.scale)
        ])
        
        NSLayoutConstraint.activate([
            signImageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 3.scale),
            signImageView.widthAnchor.constraint(equalToConstant: 313.5.scale),
            signImageView.heightAnchor.constraint(equalToConstant: ScreenSize.isIphoneXFamily ? 370.scale : 330.scale),
            signImageView.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            textLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16.scale),
            textLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16.scale),
            textLabel.topAnchor.constraint(equalTo: signImageView.bottomAnchor, constant: 19.scale)
        ])
        
        NSLayoutConstraint.activate([
            button.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16.scale),
            button.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16.scale),
            button.heightAnchor.constraint(equalToConstant: 51.scale),
            button.bottomAnchor.constraint(equalTo: bottomAnchor, constant: ScreenSize.isIphoneXFamily ? -60.scale : -20.scale)
        ])
    }
}

// MARK: Lazy initialization
private extension OSignView {
    func makeLabel() -> UILabel {
        let view = UILabel()
        view.numberOfLines = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeSignImageView() -> UIImageView {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeButton() -> UIButton {
        let attrs = TextAttributes()
            .textColor(UIColor.white)
            .font(Fonts.Qanelas.bold(size: 18.scale))
            .textAlignment(.center)
        
        let view = UIButton()
        view.layer.cornerRadius = 7.scale
        view.backgroundColor = UIColor(integralRed: 255, green: 141, blue: 91)
        view.setAttributedTitle("Continue".localized.uppercased().attributed(with: attrs), for: .normal)
        view.addTarget(self, action: #selector(onNext), for: .touchUpInside)
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
}
