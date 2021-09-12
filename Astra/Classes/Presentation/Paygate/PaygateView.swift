//
//  PaygateView.swift
//  Astra
//
//  Created by Andrey Chernyshev on 08.09.2021.
//

import UIKit

final class PaygateView: GradientView {
    lazy var backgroundImageView = makeBackgroundImageView()
    lazy var closeButton = makeCloseButton()
    lazy var restoreButton = makeRestoreButton()
    lazy var titleLabel = makeTitleLabel()
    lazy var reviewsView = makeReviewsView()
    lazy var infoCell1 = makeInfoCell(text: "Paygate.Info1")
    lazy var infoCell2 = makeInfoCell(text: "Paygate.Info2")
    lazy var optionView1 = makeOptionView()
    lazy var optionView2 = makeOptionView()
    lazy var lockImageView = makeLockImageView()
    lazy var securedLabel = makeSecuredLabel()
    lazy var subscribeButton = makeSubscribeButton()
    lazy var termsAndPolicyLabel = makeTermsAndPolicyLabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Private
private extension PaygateView {
    @objc
    private func termsAndPolicyTapped(sender: UITapGestureRecognizer) {
        guard let label = sender.view as? UILabel, let text = label.text as NSString? else {
            return
        }
        
        let termsRange = text.range(of: "Paygate.TermsOfUse".localized)
        let policyRange = text.range(of: "Paygate.PrivacyPolicy".localized)
        
        var url: URL?

        if sender.didTapAttributedTextInLabel(label: label, inRange: termsRange) {
            url = URL(string: GlobalDefinitions.termsOfServiceUrl)
        } else if sender.didTapAttributedTextInLabel(label: label, inRange: policyRange) {
            url = URL(string: GlobalDefinitions.privacyPolicyUrl)
        }
        
        guard let openUrl = url else {
            return
        }
        
        UIApplication.shared.open(openUrl, options: [:])
    }
}

// MARK: Make constraints
private extension PaygateView {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            backgroundImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            backgroundImageView.topAnchor.constraint(equalTo: topAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            closeButton.widthAnchor.constraint(equalToConstant: 24.scale),
            closeButton.heightAnchor.constraint(equalToConstant: 24.scale),
            closeButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16.scale),
            closeButton.topAnchor.constraint(equalTo: topAnchor, constant: 64.scale)
        ])
        
        NSLayoutConstraint.activate([
            restoreButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16.scale),
            restoreButton.heightAnchor.constraint(equalToConstant: 20.scale),
            restoreButton.centerYAnchor.constraint(equalTo: closeButton.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20.scale),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20.scale),
            titleLabel.topAnchor.constraint(equalTo: closeButton.bottomAnchor, constant: 16.scale)
        ])
        
        NSLayoutConstraint.activate([
            reviewsView.leadingAnchor.constraint(equalTo: leadingAnchor),
            reviewsView.trailingAnchor.constraint(equalTo: trailingAnchor),
            reviewsView.heightAnchor.constraint(equalToConstant: 136.scale),
            reviewsView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20.scale)
        ])
        
        NSLayoutConstraint.activate([
            infoCell1.leadingAnchor.constraint(equalTo: leadingAnchor),
            infoCell1.trailingAnchor.constraint(equalTo: trailingAnchor),
            infoCell1.topAnchor.constraint(equalTo: reviewsView.bottomAnchor, constant: 18.scale)
        ])
        
        NSLayoutConstraint.activate([
            infoCell2.leadingAnchor.constraint(equalTo: leadingAnchor),
            infoCell2.trailingAnchor.constraint(equalTo: trailingAnchor),
            infoCell2.topAnchor.constraint(equalTo: infoCell1.bottomAnchor, constant: 12.scale)
        ])
        
        NSLayoutConstraint.activate([
            optionView1.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16.scale),
            optionView1.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16.scale),
            optionView1.heightAnchor.constraint(equalToConstant: 76.scale),
            optionView1.topAnchor.constraint(equalTo: infoCell2.bottomAnchor, constant: 30.scale)
        ])
        
        NSLayoutConstraint.activate([
            optionView2.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16.scale),
            optionView2.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16.scale),
            optionView2.heightAnchor.constraint(equalToConstant: 76.scale),
            optionView2.topAnchor.constraint(equalTo: optionView1.bottomAnchor, constant: 8.scale)
        ])
        
        NSLayoutConstraint.activate([
            lockImageView.widthAnchor.constraint(equalToConstant: 17.scale),
            lockImageView.heightAnchor.constraint(equalToConstant: 17.scale),
            lockImageView.bottomAnchor.constraint(equalTo: subscribeButton.topAnchor, constant: -9.scale),
            lockImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 65.scale)
        ])
        
        NSLayoutConstraint.activate([
            securedLabel.leadingAnchor.constraint(equalTo: lockImageView.trailingAnchor, constant: 5.scale),
            securedLabel.centerYAnchor.constraint(equalTo: lockImageView.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            subscribeButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16.scale),
            subscribeButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16.scale),
            subscribeButton.heightAnchor.constraint(equalToConstant: 51.scale),
            subscribeButton.bottomAnchor.constraint(equalTo: termsAndPolicyLabel.topAnchor, constant: -38.scale)
        ])
        
        NSLayoutConstraint.activate([
            termsAndPolicyLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            termsAndPolicyLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -30.scale)
        ])
    }
}

// MARK: Lazy initialization
private extension PaygateView {
    func makeBackgroundImageView() -> UIImageView {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.image = UIImage(named: "Paygate.Background")
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeCloseButton() -> UIButton {
        let view = UIButton()
        view.setImage(UIImage(named: "Paygate.Close"), for: .normal)
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeRestoreButton() -> TapAreaButton {
        let attrs = TextAttributes()
            .textColor(UIColor(integralRed: 252, green: 252, blue: 252))
            .font(Fonts.Qanelas.regular(size: 14.scale))
        
        let view = TapAreaButton()
        view.setAttributedTitle("Paygate.RestorePurchases".localized.attributed(with: attrs), for: .normal)
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeTitleLabel() -> UILabel {
        let attrs = TextAttributes()
            .textColor(UIColor(integralRed: 252, green: 252, blue: 252))
            .font(Fonts.Qanelas.bold(size: 30.scale))
            .lineHeight(36.scale)
            .textAlignment(.center)
        
        let view = UILabel()
        view.numberOfLines = 0
        view.attributedText = "Paygate.Title".localized.attributed(with: attrs)
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeReviewsView() -> PaygateReviewsView {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 21.scale
        
        let view = PaygateReviewsView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = UIColor.clear
        view.isScrollEnabled = false
        view.showsHorizontalScrollIndicator = false
        view.contentInset = UIEdgeInsets(top: 0, left: 10.scale, bottom: 0, right: 10.scale)
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeInfoCell(text: String) -> PaygateInfoCell {
        let view = PaygateInfoCell()
        view.text = text.localized
        view.backgroundColor = UIColor.clear
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeOptionView() -> PaygateOptionView {
        let view = PaygateOptionView()
        view.layer.cornerRadius = 10.scale
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeLockImageView() -> UIImageView {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.image = UIImage(named: "Paygate.Lock")
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeSecuredLabel() -> UILabel {
        let attrs = TextAttributes()
            .textColor(UIColor(integralRed: 252, green: 252, blue: 252))
            .font(Fonts.Qanelas.regular(size: 14.scale))
            .lineHeight(16.scale)
        
        let view = UILabel()
        view.attributedText = "Paygate.Secured".localized.attributed(with: attrs)
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeSubscribeButton() -> UIButton {
        let attrs = TextAttributes()
            .textColor(UIColor(integralRed: 252, green: 252, blue: 252))
            .font(Fonts.Qanelas.bold(size: 18.scale))
        
        let view = UIButton()
        view.setAttributedTitle("Paygate.TryAndSubscribe".localized.attributed(with: attrs), for: .normal)
        view.backgroundColor = UIColor(integralRed: 132, green: 214, blue: 218)
        view.layer.cornerRadius = 7.scale
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeTermsAndPolicyLabel() -> UILabel {
        let attrs1 = TextAttributes()
            .font(Fonts.Qanelas.bold(size: 14.scale))
            .lineHeight(17.3.scale)
            .textColor(UIColor(integralRed: 252, green: 252, blue: 252))
        
        let attrs2 = TextAttributes()
            .font(Fonts.Qanelas.regular(size: 12.scale))
            .lineHeight(14.2.scale)
            .textColor(UIColor(integralRed: 252, green: 252, blue: 252))
        
        let terms = "Paygate.TermsOfUse".localized.attributed(with: attrs1)
        let and = "Paygate.And".localized.attributed(with: attrs2)
        let policy = "Paygate.PrivacyPolicy".localized.attributed(with: attrs1)
        
        let attributedText = NSMutableAttributedString()
        attributedText.append(terms)
        attributedText.append(and)
        attributedText.append(policy)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(termsAndPolicyTapped(sender:)))
        
        let view = UILabel()
        view.attributedText = attributedText
        view.addGestureRecognizer(tapGesture)
        view.isUserInteractionEnabled = true
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
}
