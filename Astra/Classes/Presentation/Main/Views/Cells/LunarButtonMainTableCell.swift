//
//  LunarButtonMainTableCell.swift
//  Astra
//
//  Created by Andrey Chernyshev on 16.08.2021.
//

import UIKit

final class LunarButtonMainTableCell: UITableViewCell {
    weak var mainDelegate: MainTableViewDelegate?
    
    lazy var button = makeButton()
    lazy var separator = makeSeparator()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        makeConstraints()
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Private
private extension LunarButtonMainTableCell {
    func initialize() {
        backgroundColor = UIColor.clear
        contentView.backgroundColor = UIColor.clear
        
        selectionStyle = .none
    }
    
    @objc
    func tapped() {
        mainDelegate?.mainTableViewLunarDidTapped()
    }
}

// MARK: Make constraints
private extension LunarButtonMainTableCell {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            button.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16.scale),
            button.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16.scale),
            button.topAnchor.constraint(equalTo: contentView.topAnchor),
            button.heightAnchor.constraint(equalToConstant: 52.scale)
        ])
        
        NSLayoutConstraint.activate([
            separator.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20.scale),
            separator.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20.scale),
            separator.heightAnchor.constraint(equalToConstant: 1.scale),
            separator.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}

// MARK: Lazy initialization
private extension LunarButtonMainTableCell {
    func makeButton() -> GradientButton {
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
        view.layer.cornerRadius = 4.scale
        view.setAttributedTitle("Main.LunarButton.Text".localized.uppercased().attributed(with: attrs), for: .normal)
        view.addTarget(self, action: #selector(tapped), for: .touchUpInside)
        view.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(view)
        return view
    }
    
    func makeSeparator() -> UIView {
        let view = UIView()
        view.backgroundColor = UIColor(integralRed: 233, green: 231, blue: 228)
        view.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(view)
        return view
    }
}
