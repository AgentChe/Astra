//
//  TarotsMainTableCell.swift
//  Astra
//
//  Created by Andrey Chernyshev on 17.08.2021.
//

import UIKit

final class TarotsMainTableCell: UITableViewCell {
    weak var mainDelegate: MainTableViewDelegate?
    
    lazy var loveButton = makeButton(code: 1,
                                     image: "Main.Tarot.Love",
                                     title: "Main.Tarot.Love.Title")
    lazy var careerButton = makeButton(code: 2,
                                     image: "Main.Tarot.Career",
                                     title: "Main.Tarot.Career.Title")
    lazy var moneyButton = makeButton(code: 3,
                                     image: "Main.Tarot.Money",
                                     title: "Main.Tarot.Money.Title")
    
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
private extension TarotsMainTableCell {
    @objc
    func tapped(sender: TarotTableButton) {
        mainDelegate?.mainTableViewTarotDidTapped(code: sender.code)
    }
}

// MARK: Private
private extension TarotsMainTableCell {
    func initialize() {
        backgroundColor = UIColor.clear
        contentView.backgroundColor = UIColor.clear
        
        selectionStyle = .none
    }
}

// MARK: Make constraints
private extension TarotsMainTableCell {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            loveButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16.scale),
            loveButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 2.scale),
            loveButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -2.scale)
        ])
        
        NSLayoutConstraint.activate([
            careerButton.leadingAnchor.constraint(equalTo: loveButton.trailingAnchor, constant: 12.scale),
            careerButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 2.scale),
            careerButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -2.scale)
        ])
        
        NSLayoutConstraint.activate([
            moneyButton.leadingAnchor.constraint(equalTo: careerButton.trailingAnchor, constant: 12.scale),
            moneyButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16.scale),
            moneyButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 2.scale),
            moneyButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -2.scale)
        ])
    }
}

// MARK: Lazy initialization
private extension TarotsMainTableCell {
    func makeButton(code: Int, image: String, title: String) -> TarotTableButton {
        let attrs = TextAttributes()
            .textColor(UIColor(integralRed: 31, green: 31, blue: 31))
            .font(Fonts.Qanelas.bold(size: 17.scale))
            .lineHeight(23.8.scale)
        
        let view = TarotTableButton()
        view.code = code
        view.pictureView.image = UIImage(named: image)
        view.textLabel.attributedText = title.localized.attributed(with: attrs)
        view.backgroundColor = UIColor(integralRed: 252, green: 252, blue: 252)
        view.layer.cornerRadius = 7.scale
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.1
        view.layer.shadowOffset = .zero
        view.layer.shadowRadius = 4.scale
        view.addTarget(self, action: #selector(tapped(sender:)), for: .touchUpInside)
        view.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(view)
        return view
    }
}
