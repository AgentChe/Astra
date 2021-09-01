//
//  OFeelTodayView.swift
//  Astra
//
//  Created by Andrey Chernyshev on 01.09.2021.
//

import UIKit
import RxSwift
import RxCocoa

final class OFeelTodayView: OSlideView {
    lazy var titleLabel = makeTitleLabel()
    lazy var imageView = makeImageView()
    lazy var slider = makeSlider()
    lazy var button = makeButton()
    
    private lazy var disposeBag = DisposeBag()
    
    private lazy var userManager = UserManagerCore()
    
    override init(step: OnboardingView.Step) {
        super.init(step: step)
        
        makeConstraints()
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        update(sender: slider)
    }
}

// MARK: Private
private extension OFeelTodayView {
    func initialize() {
        button.rx.tap
            .flatMapLatest { [weak self] _ -> Single<Bool> in
                guard let self = self else {
                    return .never()
                }

                let value = Int(self.slider.value)
                
                return self.userManager
                    .set(feelToday: value)
                    .map { true }
                    .catchAndReturn(false)
            }
            .asDriver(onErrorDriveWith: .never())
            .drive(onNext: { [weak self] success in
                guard success else {
                    Toast.notify(with: "Onboarding.FailedToSave".localized, style: .danger)
                    return
                }

                self?.onNext()
            })
            .disposed(by: disposeBag)
    }
    
    @objc
    func update(sender: UISlider) {
        sender.value = round(sender.value)
        
        if slider.value <= 2 {
            imageView.image = UIImage(named: "Onboarding.FeelToday1")
        } else if slider.value <= 5 {
            imageView.image = UIImage(named: "Onboarding.FeelToday2")
        } else {
            imageView.image = UIImage(named: "Onboarding.FeelToday3")
        }
    }
}

// MARK: Make constraints
private extension OFeelTodayView {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 17.scale),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -17.scale),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: ScreenSize.isIphoneXFamily ? 130.scale : 70.scale)
        ])
        
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 312.scale),
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: ScreenSize.isIphoneXFamily ? 242.scale : 157.scale),
            imageView.widthAnchor.constraint(equalToConstant: 322.scale)
        ])
        
        NSLayoutConstraint.activate([
            slider.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32.scale),
            slider.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32.scale),
            slider.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 62.scale)
        ])
        
        NSLayoutConstraint.activate([
            button.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 26.scale),
            button.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -26.scale),
            button.heightAnchor.constraint(equalToConstant: 60.scale),
            button.bottomAnchor.constraint(equalTo: bottomAnchor, constant: ScreenSize.isIphoneXFamily ? -60.scale : -20.scale)
        ])
    }
}

// MARK: Lazy initialization
private extension OFeelTodayView {
    func makeTitleLabel() -> UILabel {
        let attrs = TextAttributes()
            .textColor(UIColor(integralRed: 31, green: 31, blue: 31))
            .font(Fonts.Qanelas.bold(size: 30.scale))
            .lineHeight(36.scale)
            .textAlignment(.center)
        
        let view = UILabel()
        view.numberOfLines = 0
        view.attributedText = "Onboarding.FeelToday.Title".localized.attributed(with: attrs)
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeImageView() -> UIImageView {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeSlider() -> UISlider {
        let view = UISlider()
        view.minimumValue = 1
        view.maximumValue = 7
        view.minimumTrackTintColor = UIColor(integralRed: 255, green: 141, blue: 91)
        view.maximumTrackTintColor = UIColor.white.withAlphaComponent(0.3)
        view.thumbTintColor = UIColor(integralRed: 255, green: 141, blue: 91)
        view.addTarget(self, action: #selector(update(sender:)), for: .valueChanged)
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
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
}
