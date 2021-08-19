//
//  TarotReservedTableCell.swift
//  Astra
//
//  Created by Andrey Chernyshev on 19.08.2021.
//

import UIKit

final class TarotReservedTableCell: UITableViewCell {
    lazy var stars1ImageView = makeStarsImageView()
    lazy var titleLabel = makeLabel()
    lazy var stars2ImageView = makeStarsImageView()
    
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
private extension TarotReservedTableCell {
    func initialize() {
        backgroundColor = UIColor.clear
        contentView.backgroundColor = UIColor.clear
        
        selectionStyle = .none
    }
}

// MARK: Make constraints
private extension TarotReservedTableCell {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            stars1ImageView.widthAnchor.constraint(equalToConstant: 13.scale),
            stars1ImageView.heightAnchor.constraint(equalToConstant: 15.5.scale),
            stars1ImageView.trailingAnchor.constraint(equalTo: titleLabel.leadingAnchor, constant: -4.scale),
            stars1ImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            stars2ImageView.widthAnchor.constraint(equalToConstant: 13.scale),
            stars2ImageView.heightAnchor.constraint(equalToConstant: 15.5.scale),
            stars2ImageView.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 4.scale),
            stars2ImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
}

// MARK: Lazy initialization
private extension TarotReservedTableCell {
    func makeStarsImageView() -> UIImageView {
        let view = UIImageView()
        view.image = UIImage(named: "Tarot.Stars")
        view.contentMode = .scaleAspectFit
        view.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(view)
        return view
    }
    
    func makeLabel() -> UILabel {
        let attrs = TextAttributes()
            .textColor(UIColor(integralRed: 243, green: 234, blue: 156))
            .font(Fonts.Qanelas.bold(size: 17.scale))
            .lineHeight(23.8.scale)
        
        let view = UILabel()
        view.attributedText = "Tarot.Reversed".localized.attributed(with: attrs)
        view.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(view)
        return view
    }
}
