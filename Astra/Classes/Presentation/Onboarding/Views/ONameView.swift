//
//  ONameView.swift
//  Astra
//
//  Created by Andrey Chernyshev on 13.08.2021.
//

import UIKit
import RxSwift

protocol ONameViewDelegate: AnyObject {
    func nameViewChange(name: String)
}

final class ONameView: OSlideView {
    weak var nameDelegate: ONameViewDelegate?
    
    lazy var titleLabel = makeTitleLabel()
    lazy var subTitleLabel = makeSubTitleLabel()
    lazy var textField = makeTextField()
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
            .logEvent(name: "Name Screen", parameters: [:])
        
        textField.becomeFirstResponder()
    }
}

// MARK: Private
private extension ONameView {
    func initialize() {
        textField.rx.text
            .startWith(nil)
            .subscribe(onNext: { [weak self] text in
                let text = text ?? ""
                self?.button.isHidden = text.isEmpty
            })
            .disposed(by: disposeBag)
        
        button.rx.tap
            .flatMapLatest { [weak self] _ -> Single<Bool> in
                guard
                    let self = self,
                    let name = self.textField.text,
                    !name.isEmpty
                else {
                    return .never()
                }
                
                return self.userManager
                    .set(name: name)
                    .map { true }
                    .catchAndReturn(false)
            }
            .subscribe(onNext: { [weak self] success in
                guard success else {
                    Toast.notify(with: "Onboarding.FailedToSave".localized, style: .danger)
                    return
                }

                self?.endEditing(true)
                
                self?.nameDelegate?.nameViewChange(name: self?.textField.text ?? "")
                
                self?.onNext()
            })
            .disposed(by: disposeBag)
    }
}

// MARK: Make constraints
private extension ONameView {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16.scale),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16.scale),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: ScreenSize.isIphoneXFamily ? 130.scale : 70.scale)
        ])
        
        NSLayoutConstraint.activate([
            subTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16.scale),
            subTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16.scale),
            subTitleLabel.bottomAnchor.constraint(equalTo: textField.topAnchor, constant: -19.scale)
        ])
        
        NSLayoutConstraint.activate([
            textField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16.scale),
            textField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16.scale),
            textField.heightAnchor.constraint(equalToConstant: 59.scale),
            textField.topAnchor.constraint(equalTo: topAnchor, constant: ScreenSize.isIphoneXFamily ? 347.scale : 247.scale)
        ])
        
        NSLayoutConstraint.activate([
            button.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16.scale),
            button.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16.scale),
            button.heightAnchor.constraint(equalToConstant: 51.scale),
            button.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 41.scale)
        ])
    }
}

// MARK: Lazy initialization
private extension ONameView {
    func makeTitleLabel() -> UILabel {
        let attrs = TextAttributes()
            .textColor(UIColor(integralRed: 31, green: 31, blue: 31))
            .font(Fonts.Qanelas.bold(size: 30.scale))
            .lineHeight(36.scale)
            .textAlignment(.center)
        
        let view = UILabel()
        view.numberOfLines = 0
        view.attributedText = "Onboarding.Name.Title".localized.attributed(with: attrs)
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
        view.attributedText = "Onboarding.Name.SubTitle".localized.attributed(with: attrs)
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeTextField() -> PaddingTextField {
        let view = PaddingTextField()
        view.textPadding = UIEdgeInsets(top: 0, left: 8.scale, bottom: 0, right: 8.scale)
        view.backgroundColor = UIColor.white
        view.autocorrectionType = .no
        view.layer.cornerRadius = 7.scale
        view.layer.masksToBounds = true
        view.textColor = UIColor(integralRed: 63, green: 63, blue: 63)
        view.font = Fonts.Qanelas.regular(size: 24.scale)
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
        view.setAttributedTitle("Onboarding.Name.Button".localized.uppercased().attributed(with: attrs), for: .normal)
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
}
