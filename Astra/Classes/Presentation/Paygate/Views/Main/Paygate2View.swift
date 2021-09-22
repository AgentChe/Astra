//
//  Paygate2View.swift
//  Astra
//
//  Created by Andrey Chernyshev on 22.09.2021.
//

import UIKit
import RxSwift

final class Paygate2View: PaygateView {
    lazy var imageView = makeImageView()
    lazy var closeButton = makeCloseButton()
    lazy var titleLabel = makeTitleLabel()
    lazy var subTitleLabel = makeSubTitleLabel()
    lazy var infoCell1 = makeInfoCell(text: "Paygate2.Info1")
    lazy var infoCell2 = makeInfoCell(text: "Paygate2.Info2")
    lazy var infoCell3 = makeInfoCell(text: "Paygate2.Info3")
    lazy var infoCell4 = makeInfoCell(text: "Paygate2.Info4")
    lazy var infoCell5 = makeInfoCell(text: "Paygate2.Info5")
    lazy var infoCell6 = makeInfoCell(text: "Paygate2.Info6")
    lazy var firstOptionView = makeOptionView(image: "Paygate2.Option1")
    lazy var secondOptionView = makeOptionView(image: "Paygate2.Option2")
    lazy var thirdOptionView = makeOptionView(image: "Paygate2.Option3")
    lazy var subscribeButton = makeSubscribeButton()
    lazy var restoreButton = makeRestoreButton()
    lazy var termsButton = makeTermsButton()
    lazy var privacyButton = makePrivacyButton()
    lazy var preloader = makePreloader()
    
    private lazy var disposeBag = DisposeBag()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        makeConstraints()
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func activity(_ isActivity: Bool) {
        restoreButton.isHidden = isActivity
        subscribeButton.isHidden = isActivity
        firstOptionView.isHidden = isActivity
        secondOptionView.isHidden = isActivity
        thirdOptionView.isHidden = isActivity
        
        isActivity ? preloader.startAnimating() : preloader.stopAnimating()
    }
}

// MARK: Private
private extension Paygate2View {
    func initialize() {
        closeButton.rx.tap
            .bind(to: didCloseTapped)
            .disposed(by: disposeBag)
        
        restoreButton.rx.tap
            .bind(to: didRestoreTapped)
            .disposed(by: disposeBag)
        
        Observable
            .merge(
                termsButton.rx.tap
                    .map { GlobalDefinitions.termsOfServiceUrl },
                
                privacyButton.rx.tap
                    .map { GlobalDefinitions.privacyPolicyUrl }
            )
            .subscribe(onNext: { path in
                guard let url = URL(string: path) else {
                    return
                }
                
                UIApplication.shared.open(url, options: [:])
            })
            .disposed(by: disposeBag)
        
        subscribeButton.rx.tap
            .subscribe(onNext: { [weak self] in
                guard let self = self else {
                    return
                }
                
                let option = [self.firstOptionView, self.secondOptionView, self.thirdOptionView]
                    .first(where: { $0.isSelected })?
                    .option
                
                guard let option = option else {
                    return
                }
                
                self.didSubscribeTapped.accept(option.productId)
            })
            .disposed(by: disposeBag)
        
        backgroundColor = UIColor(integralRed: 31, green: 31, blue: 31)
        
        closeButton.isHidden = config.blockEverything
        
        firstOptionView.isSelected = false
        secondOptionView.isSelected = true
        thirdOptionView.isSelected = false
        
        addOptionActions()
    }
    
    func addOptionActions() {
        let firstTapGesture = UITapGestureRecognizer()
        firstOptionView.isUserInteractionEnabled = true
        firstOptionView.addGestureRecognizer(firstTapGesture)
        
        let secondTapGesture = UITapGestureRecognizer()
        secondOptionView.isUserInteractionEnabled = true
        secondOptionView.addGestureRecognizer(secondTapGesture)
        
        let thirdTapGesture = UITapGestureRecognizer()
        thirdOptionView.isUserInteractionEnabled = true
        thirdOptionView.addGestureRecognizer(thirdTapGesture)
        
        Observable
            .merge(
                firstTapGesture.rx.event
                    .map { _ in (true, false, false) },
                
                secondTapGesture.rx.event
                    .map { _ in (false, true, false) },
                
                thirdTapGesture.rx.event
                    .map { _ in (false, false, true) }
            )
            .subscribe(onNext: { [weak self] opt1, opt2, opt3 in
                self?.firstOptionView.isSelected = opt1
                self?.secondOptionView.isSelected = opt2
                self?.thirdOptionView.isSelected = opt3
            })
            .disposed(by: disposeBag)
    }
}

// MARK: Make constraints
private extension Paygate2View {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.heightAnchor.constraint(equalToConstant: ScreenSize.isIphoneXFamily ? 317.scale : 205.scale)
        ])
        
        NSLayoutConstraint.activate([
            closeButton.widthAnchor.constraint(equalToConstant: 24.scale),
            closeButton.heightAnchor.constraint(equalToConstant: 24.scale),
            closeButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16.scale),
            closeButton.topAnchor.constraint(equalTo: topAnchor, constant: ScreenSize.isIphoneXFamily ? 64.scale : 30.scale)
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16.scale),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16.scale),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: ScreenSize.isIphoneXFamily ? 262.scale : 162.scale)
        ])
        
        NSLayoutConstraint.activate([
            subTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16.scale),
            subTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16.scale),
            subTitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8.scale)
        ])
        
        NSLayoutConstraint.activate([
            infoCell1.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 29.scale),
            infoCell1.topAnchor.constraint(equalTo: subTitleLabel.bottomAnchor, constant: ScreenSize.isIphoneXFamily ? 23.scale : 16.scale)
        ])
        
        NSLayoutConstraint.activate([
            infoCell2.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 29.scale),
            infoCell2.topAnchor.constraint(equalTo: infoCell1.bottomAnchor, constant: 12.scale)
        ])
        
        NSLayoutConstraint.activate([
            infoCell3.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 29.scale),
            infoCell3.topAnchor.constraint(equalTo: infoCell2.bottomAnchor, constant: 12.scale)
        ])
        
        NSLayoutConstraint.activate([
            infoCell4.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 191.scale),
            infoCell4.topAnchor.constraint(equalTo: subTitleLabel.bottomAnchor, constant: ScreenSize.isIphoneXFamily ? 23.scale : 16.scale)
        ])
        
        NSLayoutConstraint.activate([
            infoCell5.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 191.scale),
            infoCell5.topAnchor.constraint(equalTo: infoCell4.bottomAnchor, constant: 12.scale)
        ])
        
        NSLayoutConstraint.activate([
            infoCell6.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 191.scale),
            infoCell6.topAnchor.constraint(equalTo: infoCell5.bottomAnchor, constant: 12.scale)
        ])
        
        NSLayoutConstraint.activate([
            firstOptionView.widthAnchor.constraint(equalToConstant: 109.scale),
            firstOptionView.heightAnchor.constraint(equalToConstant: ScreenSize.isIphoneXFamily ? 150.scale : 142.scale),
            firstOptionView.trailingAnchor.constraint(equalTo: secondOptionView.leadingAnchor, constant: -8.scale),
            firstOptionView.bottomAnchor.constraint(equalTo: subscribeButton.topAnchor, constant: -24.scale)
        ])
        
        NSLayoutConstraint.activate([
            secondOptionView.widthAnchor.constraint(equalToConstant: 109.scale),
            secondOptionView.heightAnchor.constraint(equalToConstant: ScreenSize.isIphoneXFamily ? 150.scale : 142.scale),
            secondOptionView.centerXAnchor.constraint(equalTo: centerXAnchor),
            secondOptionView.bottomAnchor.constraint(equalTo: subscribeButton.topAnchor, constant: -24.scale)
        ])
        
        NSLayoutConstraint.activate([
            thirdOptionView.widthAnchor.constraint(equalToConstant: 109.scale),
            thirdOptionView.heightAnchor.constraint(equalToConstant: ScreenSize.isIphoneXFamily ? 150.scale : 142.scale),
            thirdOptionView.leadingAnchor.constraint(equalTo: secondOptionView.trailingAnchor, constant: 8.scale),
            thirdOptionView.bottomAnchor.constraint(equalTo: subscribeButton.topAnchor, constant: -24.scale)
        ])
        
        NSLayoutConstraint.activate([
            subscribeButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16.scale),
            subscribeButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16.scale),
            subscribeButton.heightAnchor.constraint(equalToConstant: 51.scale),
            subscribeButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: ScreenSize.isIphoneXFamily ? -85.scale : -60.scale)
        ])
        
        NSLayoutConstraint.activate([
            restoreButton.trailingAnchor.constraint(equalTo: termsButton.leadingAnchor, constant: -40.scale),
            restoreButton.heightAnchor.constraint(equalToConstant: 20.scale),
            restoreButton.centerYAnchor.constraint(equalTo: termsButton.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            termsButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            termsButton.heightAnchor.constraint(equalToConstant: 20.scale),
            termsButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: ScreenSize.isIphoneXFamily ? -35.scale : -16.scale)
        ])
        
        NSLayoutConstraint.activate([
            privacyButton.leadingAnchor.constraint(equalTo: termsButton.trailingAnchor, constant: 40.scale),
            privacyButton.heightAnchor.constraint(equalToConstant: 20.scale),
            privacyButton.centerYAnchor.constraint(equalTo: termsButton.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            preloader.centerXAnchor.constraint(equalTo: subscribeButton.centerXAnchor),
            preloader.centerYAnchor.constraint(equalTo: subscribeButton.centerYAnchor)
        ])
    }
}

// MARK: Lazy initialization
private extension Paygate2View {
    func makeImageView() -> UIImageView {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.image = UIImage(named: ScreenSize.isIphoneXFamily ? "Paygate2.Image" : "Paygate2.Image2")
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeCloseButton() -> UIButton {
        let view = UIButton()
        view.setImage(UIImage(named: "Paygate2.Close"), for: .normal)
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeTitleLabel() -> UILabel {
        let attrs = TextAttributes()
            .textColor(UIColor(integralRed: 252, green: 252, blue: 252))
            .font(Fonts.Qanelas.bold(size: 30.scale))
            .lineHeight(30.scale)
            .textAlignment(.center)
        
        let view = UILabel()
        view.numberOfLines = 0
        view.attributedText = "Paygate2.Title".localized.attributed(with: attrs)
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeSubTitleLabel() -> UILabel {
        let attrs = TextAttributes()
            .textColor(UIColor(integralRed: 252, green: 252, blue: 252))
            .font(Fonts.Qanelas.regular(size: 19.scale))
            .lineHeight(22.8.scale)
            .textAlignment(.center)
        
        let view = UILabel()
        view.numberOfLines = 0
        view.attributedText = "Paygate2.SubTitle".localized.attributed(with: attrs)
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeInfoCell(text: String) -> Paygate2InfoCell {
        let view = Paygate2InfoCell()
        view.text = text.localized
        view.backgroundColor = UIColor.clear
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeOptionView(image: String) -> Paygate2OptionView {
        let view = Paygate2OptionView()
        view.imageView.image = UIImage(named: image)
        view.layer.cornerRadius = 8.scale
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeSubscribeButton() -> GradientButton {
        let attrs = TextAttributes()
            .textColor(UIColor(integralRed: 252, green: 252, blue: 252))
            .font(Fonts.Qanelas.bold(size: 18.scale))
        
        let view = GradientButton()
        view.gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
        view.gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
        view.gradientLayer.colors = [
            UIColor(integralRed: 128, green: 221, blue: 216).cgColor,
            UIColor(integralRed: 176, green: 160, blue: 233).cgColor,
        ]
        view.setAttributedTitle("Paygate2.Subscribe".localized.attributed(with: attrs), for: .normal)
        view.layer.cornerRadius = 7.scale
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeRestoreButton() -> TapAreaButton {
        let attrs = TextAttributes()
            .textColor(UIColor.white.withAlphaComponent(0.6))
            .font(Fonts.Qanelas.semiBold(size: 14.scale))
        
        let view = TapAreaButton()
        view.setAttributedTitle("Paygate2.Restore".localized.attributed(with: attrs), for: .normal)
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeTermsButton() -> TapAreaButton {
        let attrs = TextAttributes()
            .textColor(UIColor.white.withAlphaComponent(0.6))
            .font(Fonts.Qanelas.semiBold(size: 14.scale))
        
        let view = TapAreaButton()
        view.setAttributedTitle("Paygate2.Terms".localized.attributed(with: attrs), for: .normal)
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makePrivacyButton() -> TapAreaButton {
        let attrs = TextAttributes()
            .textColor(UIColor.white.withAlphaComponent(0.6))
            .font(Fonts.Qanelas.semiBold(size: 14.scale))
        
        let view = TapAreaButton()
        view.setAttributedTitle("Paygate2.Privacy".localized.attributed(with: attrs), for: .normal)
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makePreloader() -> UIActivityIndicatorView {
        let view = UIActivityIndicatorView()
        view.style = .whiteLarge
        view.hidesWhenStopped = true
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
}
