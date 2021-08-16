//
//  DailyTarotMainTableCell.swift
//  Astra
//
//  Created by Andrey Chernyshev on 17.08.2021.
//

import UIKit

final class DailyTarotMainTableCell: UITableViewCell {
    weak var mainDelegate: MainTableViewDelegate?
    
    lazy var container = makeContainer()
    lazy var pictureView = makeImageView()
    lazy var titleLabel = makeTitleLabel()
    lazy var infoLabel = makeTextLabel()
    
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
private extension DailyTarotMainTableCell {
    @objc
    func tapped() {
        mainDelegate?.mainTableViewTarotDidTapped(code: 0)
    }
}

// MARK: Private
private extension DailyTarotMainTableCell {
    func initialize() {
        backgroundColor = UIColor.clear
        contentView.backgroundColor = UIColor.clear
        
        selectionStyle = .none
    }
}

// MARK: Make constraints
private extension DailyTarotMainTableCell {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            container.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16.scale),
            container.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16.scale),
            container.topAnchor.constraint(equalTo: contentView.topAnchor),
            container.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            pictureView.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            pictureView.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            pictureView.topAnchor.constraint(equalTo: container.topAnchor),
            pictureView.heightAnchor.constraint(equalToConstant: 163.scale)
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 12.scale),
            titleLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -12.scale),
            titleLabel.topAnchor.constraint(equalTo: pictureView.bottomAnchor, constant: 8.scale)
        ])
        
        NSLayoutConstraint.activate([
            infoLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 12.scale),
            infoLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -12.scale),
            infoLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 2.scale),
            infoLabel.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -12.scale)
        ])
    }
}

// MARK: Lazy initialization
private extension DailyTarotMainTableCell {
    func makeContainer() -> UIButton {
        let view = UIButton()
        view.backgroundColor = UIColor(integralRed: 252, green: 252, blue: 252)
        view.layer.cornerRadius = 7.scale
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.1
        view.layer.shadowOffset = .zero
        view.layer.shadowRadius = 4.scale
        view.addTarget(self, action: #selector(tapped), for: .touchUpInside)
        view.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(view)
        return view
    }
    
    func makeImageView() -> UIImageView {
        let view = UIImageView()
        view.isUserInteractionEnabled = false
        view.image = UIImage(named: "Main.Tarot.Daily")
        view.contentMode = .scaleAspectFill
        view.layer.cornerRadius = 7.scale
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(view)
        return view
    }
    
    func makeTitleLabel() -> UILabel {
        let attrs = TextAttributes()
            .textColor(UIColor(integralRed: 31, green: 31, blue: 31))
            .font(Fonts.Qanelas.bold(size: 17.scale))
            .lineHeight(23.8.scale)
        
        let view = UILabel()
        view.isUserInteractionEnabled = false
        view.numberOfLines = 0
        view.attributedText = "Main.Tarot.Daily.Title".localized.attributed(with: attrs)
        view.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(view)
        return view
    }
    
    func makeTextLabel() -> UILabel {
        let attrs = TextAttributes()
            .textColor(UIColor(integralRed: 63, green: 63, blue: 63))
            .font(Fonts.Qanelas.regular(size: 17.scale))
            .lineHeight(20.4.scale)
        
        let view = UILabel()
        view.isUserInteractionEnabled = false
        view.numberOfLines = 0
        view.attributedText = "Main.Tarot.Daily.Text".localized.attributed(with: attrs)
        view.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(view)
        return view
    }
}
