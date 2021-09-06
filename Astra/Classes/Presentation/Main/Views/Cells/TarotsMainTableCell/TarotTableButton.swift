//
//  TarotTableView.swift
//  Astra
//
//  Created by Andrey Chernyshev on 17.08.2021.
//

import UIKit

final class TarotTableButton: UIButton {
    lazy var code = -1
    
    lazy var pictureView = makeImageView()
    lazy var textLabel = makeTitleLabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var intrinsicContentSize: CGSize {
        CGSize(width: 123.scale, height: 168.scale)
    }
}

// MARK: Make constraints
private extension TarotTableButton {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            pictureView.leadingAnchor.constraint(equalTo: leadingAnchor),
            pictureView.trailingAnchor.constraint(equalTo: trailingAnchor),
            pictureView.topAnchor.constraint(equalTo: topAnchor),
            pictureView.heightAnchor.constraint(equalToConstant: 136.scale)
        ])
        
        NSLayoutConstraint.activate([
            textLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            textLabel.topAnchor.constraint(equalTo: pictureView.bottomAnchor, constant: 4.scale)
        ])
    }
}

// MARK: Lazy initialization
private extension TarotTableButton {
    func makeImageView() -> UIImageView {
        let view = UIImageView()
        view.isUserInteractionEnabled = false
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        view.layer.cornerRadius = 7.scale
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeTitleLabel() -> UILabel {
        let view = UILabel()
        view.isUserInteractionEnabled = false
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
}
