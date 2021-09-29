//
//  OBirthdateView.swift
//  Astra
//
//  Created by Andrey Chernyshev on 11.08.2021.
//

import UIKit
import RxSwift

protocol OBirthdateViewDelegate: AnyObject {
    func birthdateViewChange(date: Date)
}

final class OBirthdateView: OSlideView {
    weak var birthdateDelegate: OBirthdateViewDelegate?
    
    lazy var titleLabel = makeTitleLabel()
    lazy var subTitleLabel = makeSubTitleLabel()
    lazy var datePickerView = makeDatePickerView()
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
            .logEvent(name: "Birthdate Screen", parameters: [:])
    }
}

// MARK: Private
private extension OBirthdateView {
    func initialize() {
        button.rx.tap
            .flatMapLatest { [weak self] _ -> Single<Bool> in
                guard let self = self else {
                    return .never()
                }
                
                let date = self.map(date: self.datePickerView.date)
                
                return self.userManager
                    .set(birthDate: date)
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
                
                self.birthdateDelegate?.birthdateViewChange(date: self.datePickerView.date)

                self.onNext()
            })
            .disposed(by: disposeBag)
    }
    
    func map(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: date)
    }
}

// MARK: Make constraints
private extension OBirthdateView {
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
            datePickerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            datePickerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            datePickerView.bottomAnchor.constraint(equalTo: button.topAnchor, constant: -80.scale),
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
private extension OBirthdateView {
    func makeTitleLabel() -> UILabel {
        let attrs = TextAttributes()
            .textColor(UIColor(integralRed: 31, green: 31, blue: 31))
            .font(Fonts.Qanelas.bold(size: 30.scale))
            .lineHeight(36.scale)
            .textAlignment(.center)
        
        let view = UILabel()
        view.numberOfLines = 0
        view.attributedText = "Onboarding.Birthdate.Title".localized.attributed(with: attrs)
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
        view.attributedText = "Onboarding.Birthdate.SubTitle".localized.attributed(with: attrs)
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeDatePickerView() -> UIDatePicker {
        let minimumDate = Calendar.current.date(byAdding: .year, value: -60, to: Date()) ?? Date()
        
        let startDate = Calendar.current.date(byAdding: .year, value: -20, to: Date()) ?? Date()
        
        let view = UIDatePicker()
        view.backgroundColor = UIColor.clear
        view.minimumDate = minimumDate
        view.datePickerMode = .date
        view.locale = Locale.current
        if #available(iOS 13.4, *) {
             view.preferredDatePickerStyle = .wheels
        }
        view.setValue(UIColor(integralRed: 63, green: 63, blue: 63), forKeyPath: "textColor")
        view.datePickerMode = .countDownTimer
        view.datePickerMode = .date
        view.date = startDate
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
