//
//  Paygate4InfoCell.swift
//  Astra
//
//  Created by Andrey Chernyshev on 23.09.2021.
//

import UIKit

final class Paygate4InfoCell: UIView {
    var text: String = "" {
        didSet {
            let attrs = TextAttributes()
                .textColor(UIColor(integralRed: 252, green: 252, blue: 252))
                .font(Fonts.Qanelas.regular(size: 17.scale))
                .lineHeight(23.8.scale)
            label.attributedText = text.attributed(with: attrs)
        }
    }
    
    lazy var imageView = makeImageView()
    lazy var label = makeLabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Make constraints
private extension Paygate4InfoCell {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: 18.scale),
            imageView.heightAnchor.constraint(equalToConstant: 24.scale),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.topAnchor.constraint(equalTo: topAnchor)
        ])
        
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 26.scale),
            label.trailingAnchor.constraint(equalTo: trailingAnchor),
            label.topAnchor.constraint(equalTo: topAnchor),
            label.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

// MARK: Lazy initialization
private extension Paygate4InfoCell {
    func makeImageView() -> UIImageView {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.image = UIImage(named: "Paygate4.Star")
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeLabel() -> UILabel {
        let view = UILabel()
        view.numberOfLines = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
}
