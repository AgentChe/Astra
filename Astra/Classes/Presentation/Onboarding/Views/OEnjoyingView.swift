//
//  OEnjoyingView.swift
//  Astra
//
//  Created by Andrey Chernyshev on 11.08.2021.
//

import UIKit
import RxSwift

final class OEnjoyingView: OSlideView {
    lazy var titleLabel = makeTitleLabel()
    lazy var subTitleLabel = makeSubTitleLabel()
    lazy var scrollView = makeScrollView()
    lazy var cell1 = makeCell(title: "Onboarding.Enjoying.Cell1", tag: 0)
    lazy var cell2 = makeCell(title: "Onboarding.Enjoying.Cell2", tag: 1)
    lazy var cell3 = makeCell(title: "Onboarding.Enjoying.Cell3", tag: 2)
    lazy var cell4 = makeCell(title: "Onboarding.Enjoying.Cell4", tag: 3)
    lazy var cell5 = makeCell(title: "Onboarding.Enjoying.Cell5", tag: 4)
    lazy var cell6 = makeCell(title: "Onboarding.Enjoying.Cell6", tag: 5)
    lazy var cell7 = makeCell(title: "Onboarding.Enjoying.Cell7", tag: 6)
    lazy var button = makeButton()
    
    private lazy var disposeBag = DisposeBag()
    
    private lazy var userManager = UserManagerCore()
    
    override init(step: OnboardingView.Step) {
        super.init(step: step)
        
        makeConstraints()
        initialize()
        changeButtonHidden()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func moveToThis() {
        super.moveToThis()
        
        SDKStorage.shared
            .amplitudeManager
            .logEvent(name: "Enjoy Screen", parameters: [:])
    }
}

// MARK: Private
private extension OEnjoyingView {
    func initialize() {
        button.rx.tap
            .flatMapLatest { [weak self] _ -> Single<Bool> in
                guard let self = self else {
                    return .never()
                }
                
                let enjoy = [
                    self.cell1, self.cell2, self.cell3, self.cell4, self.cell5, self.cell6, self.cell7
                ].filter { $0.isSelected }.map { $0.tag }
                
                return self.userManager
                    .set(enjoy: enjoy)
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
    
    @objc
    func selected(tapGesture: UITapGestureRecognizer) {
        guard let cell = tapGesture.view as? OEnjoyingCell else {
            return
        }
        
        cell.isSelected = !cell.isSelected
        
        changeButtonHidden()
    }
    
    func changeButtonHidden() {
        button.isHidden = ![cell1, cell2, cell3, cell4, cell5, cell6, cell7].map { $0.isSelected }.contains(true)
    }
}

// MARK: Make constraints
private extension OEnjoyingView {
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
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: subTitleLabel.bottomAnchor, constant: 24.scale),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            cell1.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16.scale),
            cell1.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -16.scale),
            cell1.widthAnchor.constraint(equalToConstant: 343.scale),
            cell1.topAnchor.constraint(equalTo: scrollView.topAnchor),
            cell1.heightAnchor.constraint(equalToConstant: 55.scale)
        ])
        
        NSLayoutConstraint.activate([
            cell2.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16.scale),
            cell2.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -16.scale),
            cell2.topAnchor.constraint(equalTo: cell1.bottomAnchor, constant: 8.scale),
            cell2.heightAnchor.constraint(equalToConstant: 55.scale)
        ])
        
        NSLayoutConstraint.activate([
            cell3.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16.scale),
            cell3.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -16.scale),
            cell3.topAnchor.constraint(equalTo: cell2.bottomAnchor, constant: 8.scale),
            cell3.heightAnchor.constraint(equalToConstant: 55.scale)
        ])
        
        NSLayoutConstraint.activate([
            cell4.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16.scale),
            cell4.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -16.scale),
            cell4.topAnchor.constraint(equalTo: cell3.bottomAnchor, constant: 8.scale),
            cell4.heightAnchor.constraint(equalToConstant: 55.scale)
        ])
        
        NSLayoutConstraint.activate([
            cell5.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16.scale),
            cell5.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -16.scale),
            cell5.topAnchor.constraint(equalTo: cell4.bottomAnchor, constant: 8.scale),
            cell5.heightAnchor.constraint(equalToConstant: 55.scale)
        ])
        
        NSLayoutConstraint.activate([
            cell6.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16.scale),
            cell6.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -16.scale),
            cell6.topAnchor.constraint(equalTo: cell5.bottomAnchor, constant: 8.scale),
            cell6.heightAnchor.constraint(equalToConstant: 55.scale)
        ])
        
        NSLayoutConstraint.activate([
            cell7.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16.scale),
            cell7.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -16.scale),
            cell7.topAnchor.constraint(equalTo: cell6.bottomAnchor, constant: 8.scale),
            cell7.heightAnchor.constraint(equalToConstant: 55.scale),
            cell7.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
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
private extension OEnjoyingView {
    func makeTitleLabel() -> UILabel {
        let attrs = TextAttributes()
            .textColor(UIColor(integralRed: 31, green: 31, blue: 31))
            .font(Fonts.Qanelas.bold(size: 30.scale))
            .lineHeight(36.scale)
            .textAlignment(.center)
        
        let view = UILabel()
        view.numberOfLines = 0
        view.attributedText = "Onboarding.Enjoying.Title".localized.attributed(with: attrs)
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
        view.attributedText = "Onboarding.Enjoying.SubTitle".localized.attributed(with: attrs)
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeScrollView() -> UIScrollView {
        let view = UIScrollView()
        view.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: ScreenSize.isIphoneXFamily ? 120.scale : 90.scale, right: 0)
        view.backgroundColor = UIColor.clear
        view.showsVerticalScrollIndicator = false
        view.showsHorizontalScrollIndicator = false
        view.contentInsetAdjustmentBehavior = .never
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeCell(title: String, tag: Int) -> OEnjoyingCell {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(selected(tapGesture:)))
        
        let view = OEnjoyingCell()
        view.tag = tag
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(tapGesture)
        view.isSelected = false
        view.title = title.localized
        view.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(view)
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
