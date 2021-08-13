//
//  OGenderView.swift
//  Astra
//
//  Created by Andrey Chernyshev on 11.08.2021.
//

import UIKit
import RxSwift

final class OGenderView: OSlideView {
    lazy var titleLabel = makeTitleLabel()
    lazy var subTitleLabel = makeSubTitleLabel()
    lazy var maleImageView = makeMaleImageView()
    lazy var femaleImageView = makeFemaleImageView()
    lazy var button = makeButton()
    
    private lazy var disposeBag = DisposeBag()
    
    private lazy var userManager = UserManagerCore()
    
    private var selectedGender: Gender?
    
    override init(step: OnboardingView.Step) {
        super.init(step: step)
        
        makeConstraints()
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: ONameViewDelegate
extension OGenderView: ONameViewDelegate {
    func nameViewChange(name: String) {
        let attrs = TextAttributes()
            .textColor(UIColor(integralRed: 31, green: 31, blue: 31))
            .font(Fonts.Qanelas.bold(size: 30.scale))
            .lineHeight(36.scale)
            .textAlignment(.center)
        
        let string = String(format: "Onboarding.Gender.Title".localized, name)
        titleLabel.attributedText = string.attributed(with: attrs)
    }
}

// MARK: Make constraints
private extension OGenderView {
    func initialize() {
        layer.masksToBounds = true
        
        let maleGesture = UISwipeGestureRecognizer()
        maleGesture.direction = .right
        maleImageView.isUserInteractionEnabled = true
        maleImageView.addGestureRecognizer(maleGesture)
        let male = maleGesture.rx.event.map { _ in Gender.male }
        
        let femaleGesture = UISwipeGestureRecognizer()
        femaleGesture.direction = .left
        femaleImageView.isUserInteractionEnabled = true
        femaleImageView.addGestureRecognizer(femaleGesture)
        let female = femaleGesture.rx.event.map { _ in Gender.female }
        
        Observable
            .merge(male, female)
            .subscribe(onNext: { [weak self] gender in
                self?.selectedGender = gender
                
                self?.button.isHidden = false
                
                self?.moveImages(at: gender)
            })
            .disposed(by: disposeBag)
        
        button.rx.tap
            .flatMapLatest { [weak self] _ -> Single<Bool> in
                guard let self = self, let gender = self.selectedGender else {
                    return .never()
                }
                
                let code = self.map(gender: gender)
                
                return self.userManager
                    .set(gender: code)
                    .map { true }
                    .catchAndReturn(false)
            }
            .subscribe(onNext: { [weak self] success in
                guard success else {
                    Toast.notify(with: "Onboarding.FailedToSave".localized, style: .danger)
                    return
                }

                self?.onNext()
            })
            .disposed(by: disposeBag)
    }
    
    func moveImages(at gender: Gender) {
        let ySelected = ScreenSize.isIphoneXFamily ? 287.scale : 247.scale
        let yUnselected = ScreenSize.isIphoneXFamily ? 344.scale : 304.scale
        
        UIView.animate(withDuration: 0.5, animations: { [weak self] in
            self?.maleImageView.frame.size = CGSize(width: gender == .male ? 246.scale : 148.scale,
                                                    height: gender == .male ? 286.scale : 172.scale)
            self?.maleImageView.frame.origin = CGPoint(x: gender == .male ? 64.scale : -81.scale,
                                                       y: gender == .male ? ySelected : yUnselected)
            
            self?.femaleImageView.frame.size = CGSize(width: gender == .female ? 246.scale : 148.scale,
                                                      height: gender == .female ? 286.scale : 172.scale)
            self?.femaleImageView.frame.origin = CGPoint(x: gender == .female ? 64.scale : 316.scale,
                                                         y: gender == .female ? ySelected : yUnselected)
        })
    }
    
    func map(gender: Gender) -> Int {
        switch gender {
        case .male:
            return 1
        case .female:
            return 2
        }
    }
}

// MARK: Make constraints
private extension OGenderView {
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
            button.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16.scale),
            button.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16.scale),
            button.heightAnchor.constraint(equalToConstant: 51.scale),
            button.bottomAnchor.constraint(equalTo: bottomAnchor, constant: ScreenSize.isIphoneXFamily ? -60.scale : -20.scale)
        ])
    }
}

// MARK: Lazy initialization
private extension OGenderView {
    func makeTitleLabel() -> UILabel {
        let view = UILabel()
        view.numberOfLines = 0
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
        view.attributedText = "Onboarding.Gender.SubTitle".localized.attributed(with: attrs)
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeMaleImageView() -> UIImageView {
        let view = UIImageView()
        view.frame.size = CGSize(width: 220.scale, height: 256.scale)
        view.frame.origin = CGPoint(x: -81.scale, y: ScreenSize.isIphoneXFamily ? 338.scale : 298.scale)
        view.contentMode = .scaleAspectFit
        view.image = UIImage(named: "Onboarding.Gender.Male")
        addSubview(view)
        return view
    }
    
    func makeFemaleImageView() -> UIImageView {
        let view = UIImageView()
        view.frame.size = CGSize(width: 220.scale, height: 256.scale)
        view.frame.origin = CGPoint(x: 235.scale, y: ScreenSize.isIphoneXFamily ? 338.scale : 298.scale)
        view.contentMode = .scaleAspectFit
        view.image = UIImage(named: "Onboarding.Gender.Female")
        addSubview(view)
        return view
    }
    
    func makeButton() -> UIButton {
        let attrs = TextAttributes()
            .textColor(UIColor.white)
            .font(Fonts.Qanelas.bold(size: 18.scale))
            .textAlignment(.center)
        
        let view = UIButton()
        view.isHidden = true
        view.layer.cornerRadius = 7.scale
        view.backgroundColor = UIColor(integralRed: 255, green: 141, blue: 91)
        view.setAttributedTitle("Continue".localized.uppercased().attributed(with: attrs), for: .normal)
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
}
