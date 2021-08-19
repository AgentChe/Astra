//
//  TarotView.swift
//  Astra
//
//  Created by Andrey Chernyshev on 19.08.2021.
//

import UIKit

final class TarotView: GradientView {
    lazy var backButton = makeBackButton()
    lazy var titleLabel = makeTitleLabel()
    lazy var tableView = makeTableView()
    
    private let type: TarotType
    
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
private extension TarotView {
    func initialize() {
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0, y: 1)
        gradientLayer.colors = [
            UIColor(integralRed: 241, green: 204, blue: 195).cgColor,
            UIColor(integralRed: 226, green: 101, blue: 123).cgColor
        ]
    }
}

// MARK: Make constraints
private extension TarotView {
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
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 27.scale),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

// MARK: Lazy initialization
private extension TarotView {
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
    
    func makeTableView() -> TarotTableView {
        let view = TarotTableView()
        view.backgroundColor = UIColor.clear
        view.separatorStyle = .none
        view.showsVerticalScrollIndicator = false
        view.contentInset = UIEdgeInsets(top: 0.scale, left: 0, bottom: 16.scale, right: 0)
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
}
