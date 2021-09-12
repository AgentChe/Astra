//
//  PaygateReviewsCell.swift
//  Astra
//
//  Created by Andrey Chernyshev on 10.09.2021.
//

import UIKit

final class PaygateReviewsCell: UICollectionViewCell {
    lazy var container = makeContainer()
    lazy var iconView = makeImageView()
    lazy var textLabel = makeLabel()
    lazy var cityLabel = makeLabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        makeConstraints()
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Public
extension PaygateReviewsCell {
    func setup(element: PaygateReviewsElement) {
        iconView.image = UIImage(named: element.image)
        
        textLabel.attributedText = element.text
            .attributed(with: TextAttributes()
                            .textColor(UIColor(integralRed: 63, green: 63, blue: 63))
                            .font(Fonts.Qanelas.regular(size: 17.scale))
                            .lineHeight(23.8.scale))
        
        cityLabel.attributedText = element.city
            .attributed(with: TextAttributes()
                            .textColor(UIColor(integralRed: 31, green: 31, blue: 31))
                            .font(Fonts.Qanelas.regular(size: 12.scale))
                            .lineHeight(16.8.scale))
    }
}

// MARK: Private
private extension PaygateReviewsCell {
    func initialize() {
        backgroundColor = UIColor.clear
        contentView.backgroundColor = UIColor.clear
        
        let selectedView = UIView()
        selectedView.backgroundColor = UIColor.clear
        selectedBackgroundView = selectedView
    }
}

// MARK: Make constraints
private extension PaygateReviewsCell {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            container.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            container.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            container.topAnchor.constraint(equalTo: contentView.topAnchor),
            container.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            iconView.widthAnchor.constraint(equalToConstant: 32.scale),
            iconView.heightAnchor.constraint(equalToConstant: 32.scale),
            iconView.topAnchor.constraint(equalTo: container.topAnchor, constant: 10.scale),
            iconView.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 18.scale)
        ])
        
        NSLayoutConstraint.activate([
            textLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 18.scale),
            textLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -18.scale),
            textLabel.topAnchor.constraint(equalTo: container.topAnchor, constant: 50.scale)
        ])
        
        NSLayoutConstraint.activate([
            cityLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 18.scale),
            cityLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -18.scale),
            cityLabel.topAnchor.constraint(equalTo: container.topAnchor, constant: 105.scale)
        ])
    }
}

// MARK: Lazy initialization
private extension PaygateReviewsCell {
    func makeContainer() -> UIView {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.layer.cornerRadius = 7.scale
        view.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(view)
        return view
    }
    
    func makeImageView() -> UIImageView {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(view)
        return view
    }
    
    func makeLabel() -> UILabel {
        let view = UILabel()
        view.numberOfLines = 2
        view.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(view)
        return view
    }
}
