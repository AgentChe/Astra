//
//  ChooseTarotView.swift
//  Astra
//
//  Created by Andrey Chernyshev on 19.08.2021.
//

import UIKit

final class ChooseTarotView: GradientView {
    lazy var backButton = makeBackButton()
    lazy var titleLabel = makeTitleLabel()
    lazy var subTitleLabel = makeSubTitleLabel()
    lazy var button = makeButton()
    
    lazy var cardImageView1 = makeCardImageView()
    lazy var cardImageView2 = makeCardImageView()
    lazy var cardImageView3 = makeCardImageView()
    lazy var cardImageView4 = makeCardImageView()
    lazy var cardImageView5 = makeCardImageView()
    lazy var cardImageView6 = makeCardImageView()
    lazy var cardImageView7 = makeCardImageView()
    lazy var cardImageView8 = makeCardImageView()
    lazy var cardImageView9 = makeCardImageView()
    
    private let type: TarotType
    
    private var isSelected = false
    
    init(type: TarotType) {
        self.type = type
        
        super.init(frame: .zero)
        
        makeConstraints()
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Private
private extension ChooseTarotView {
    func initialize() {
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0, y: 1)
        gradientLayer.colors = [
            UIColor(integralRed: 241, green: 204, blue: 195).cgColor,
            UIColor(integralRed: 226, green: 101, blue: 123).cgColor
        ]
        
        cardImageView1.frame.origin = CGPoint(x: 39.scale, y: ScreenSize.isIphoneXFamily ? 160.scale : 120.scale)
        cardImageView2.frame.origin = CGPoint(x: 141.scale, y: ScreenSize.isIphoneXFamily ? 160.scale : 120.scale)
        cardImageView3.frame.origin = CGPoint(x: 243.scale, y: ScreenSize.isIphoneXFamily ? 160.scale : 120.scale)
        cardImageView4.frame.origin = CGPoint(x: 39.scale, y: ScreenSize.isIphoneXFamily ? 334.scale : 274.scale)
        cardImageView5.frame.origin = CGPoint(x: 141.scale, y: ScreenSize.isIphoneXFamily ? 334.scale : 274.scale)
        cardImageView6.frame.origin = CGPoint(x: 243.scale, y: ScreenSize.isIphoneXFamily ? 334.scale : 274.scale)
        cardImageView7.frame.origin = CGPoint(x: 39.scale, y: ScreenSize.isIphoneXFamily ? 507.scale : 447.scale)
        cardImageView8.frame.origin = CGPoint(x: 141.scale, y: ScreenSize.isIphoneXFamily ? 507.scale : 447.scale)
        cardImageView9.frame.origin = CGPoint(x: 243.scale, y: ScreenSize.isIphoneXFamily ? 507.scale : 447.scale)
    }
    
    @objc
    func tapped(sender: UIGestureRecognizer) {
        guard !isSelected else {
            return
        }
        
        guard let imageView = sender.view as? UIImageView else {
            return
        }
        
        isSelected = true
        
        button.isHidden = false
        
        UIView.animate(withDuration: 0.5, animations: { [weak self] in
            self?.bringSubviewToFront(imageView)
            
            imageView.frame.size = CGSize(width: 160.scale, height: 275.scale)
            imageView.frame.origin = CGPoint(x: 107.scale, y: ScreenSize.isIphoneXFamily ? 265.scale : 265.scale)
        })
    }
}

// MARK: Make constraints
private extension ChooseTarotView {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            backButton.widthAnchor.constraint(equalToConstant: 24.scale),
            backButton.heightAnchor.constraint(equalToConstant: 24.scale),
            backButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8.scale),
            backButton.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: ScreenSize.isIphoneXFamily ? 64.scale : 40.scale)
        ])
        
        NSLayoutConstraint.activate([
            subTitleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            subTitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: ScreenSize.isIphoneXFamily ? 24.scale : 12.scale)
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
private extension ChooseTarotView {
    func makeBackButton() -> UIButton {
        let view = UIButton()
        view.setImage(UIImage(named: "Tarot.Back"), for: .normal)
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeTitleLabel() -> UILabel {
        let attrs = TextAttributes()
            .textColor(UIColor(integralRed: 31, green: 31, blue: 31))
            .font(Fonts.Qanelas.bold(size: 24.scale))
            .lineHeight(28.8.scale)
        
        let string: String
        switch type {
        case .daily:
            string = "ChooseTarot.Title.Daily".localized
        case .love:
            string = "ChooseTarot.Title.Love".localized
        case .career:
            string = "ChooseTarot.Title.Career".localized
        case .money:
            string = "ChooseTarot.Title.Money".localized
        }
        
        let view = UILabel()
        view.attributedText = string.attributed(with: attrs)
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeSubTitleLabel() -> UILabel {
        let attrs = TextAttributes()
            .textColor(UIColor(integralRed: 31, green: 31, blue: 31))
            .font(Fonts.Qanelas.regular(size: 17.scale))
            .lineHeight(23.8.scale)
        
        let view = UILabel()
        view.attributedText = "ChooseTarot.SubTitle".localized.attributed(with: attrs)
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeCardImageView() -> UIImageView {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapped(sender:)))
        
        let view = UIImageView()
        view.frame.size = CGSize(width: ScreenSize.isIphoneXFamily ? 94.scale : 84.scale,
                                 height: ScreenSize.isIphoneXFamily ? 161.5.scale : 150.scale)
        view.contentMode = .scaleAspectFill
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(tapGesture)
        view.image = UIImage(named: "Tarot.Card")
        addSubview(view)
        return view
    }
    
    func makeButton() -> UIButton {
        let attrs = TextAttributes()
            .textColor(UIColor.white)
            .font(Fonts.Qanelas.bold(size: 18.scale))
        
        let view = UIButton()
        view.isHidden = true
        view.setAttributedTitle("ChooseTarot.Button".localized.attributed(with: attrs), for: .normal)
        view.layer.cornerRadius = 7.scale
        view.backgroundColor = UIColor(integralRed: 132, green: 214, blue: 218)
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
}
