//
//  OPartnerSignView.swift
//  Astra
//
//  Created by Andrey Chernyshev on 01.09.2021.
//

import UIKit
import RxSwift

final class OPartnerSignView: OSlideView {
    lazy var titleLabel = makeTitleLabel()
    lazy var subTitleLabel = makeSubTitleLabel()
    lazy var signsPickerView = makeSignsPickerView()
    lazy var signLabel = makeSignLabel()
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
    
    override func moveToThis() {
        super.moveToThis()
        
        SDKStorage.shared
            .amplitudeManager
            .logEvent(name: "Partner Zodiac Screen", parameters: [:])
    }
}

// MARK: Private
private extension OPartnerSignView {
    func initialize() {
        let selectedSign = signsPickerView.didSelect
            .share(replay: 1, scope: .forever)
        
        button.rx.tap
            .withLatestFrom(selectedSign)
            .flatMapLatest { [weak self] selectedSign -> Single<Bool> in
                guard let self = self else {
                    return .never()
                }
                
                return self.userManager
                    .set(partnerZodiac: selectedSign.code.code)
                    .map { true }
                    .catchAndReturn(false)
            }
            .subscribe(onNext: { [weak self] success in
                guard let self = self else {
                    return
                }
                
                guard success else {
                    Toast.notify(with: "Onboarding.FailedToSave".localized, style: .danger)
                    return
                }

                self.onNext()
            })
            .disposed(by: disposeBag)
        
        selectedSign
            .subscribe(onNext: { [weak self] sign in
                let attrs = TextAttributes()
                    .textColor(UIColor(integralRed: 63, green: 63, blue: 63))
                    .font(Fonts.Qanelas.bold(size: 24.scale))
                    .lineHeight(31.2.scale)
                self?.signLabel.attributedText = sign.name.attributed(with: attrs)
            })
            .disposed(by: disposeBag)
        
        signsPickerView.setup(code: .aries)
    }
}

// MARK: Make constraints
private extension OPartnerSignView {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16.scale),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16.scale),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: ScreenSize.isIphoneXFamily ? 130.scale : 70.scale)
        ])
        
        NSLayoutConstraint.activate([
            subTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16.scale),
            subTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16.scale),
            subTitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12.scale)
        ])
        
        NSLayoutConstraint.activate([
            signsPickerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            signsPickerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            signsPickerView.heightAnchor.constraint(equalToConstant: 308.scale),
            signsPickerView.topAnchor.constraint(equalTo: subTitleLabel.bottomAnchor, constant: ScreenSize.isIphoneXFamily ? 12.scale : 2.scale)
        ])
        
        NSLayoutConstraint.activate([
            signLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            signLabel.topAnchor.constraint(equalTo: signsPickerView.bottomAnchor, constant: ScreenSize.isIphoneXFamily ? 21.scale : 4.scale)
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
private extension OPartnerSignView {
    func makeTitleLabel() -> UILabel {
        let attrs = TextAttributes()
            .textColor(UIColor(integralRed: 31, green: 31, blue: 31))
            .font(Fonts.Qanelas.bold(size: 30.scale))
            .lineHeight(36.scale)
            .textAlignment(.center)
        
        let view = UILabel()
        view.numberOfLines = 0
        view.attributedText = "Onboarding.PartnerSign.Title".localized.attributed(with: attrs)
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeSubTitleLabel() -> UILabel {
        let attrs = TextAttributes()
            .textColor(UIColor(integralRed: 63, green: 63, blue: 63))
            .font(Fonts.Qanelas.regular(size: 24.scale))
            .lineHeight(31.2.scale)
            .textAlignment(.center)
        
        let view = UILabel()
        view.numberOfLines = 0
        view.attributedText = "Onboarding.PartnerSign.Subtitle".localized.attributed(with: attrs)
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeSignsPickerView() -> PartnerSignCollectionView {
        let view = PartnerSignCollectionView(frame: .zero)
        view.backgroundColor = UIColor.clear
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeSignLabel() -> UILabel {
        let view = UILabel()
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
