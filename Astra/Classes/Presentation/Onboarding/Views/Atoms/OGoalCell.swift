//
//  OGoalCell.swift
//  Astra
//
//  Created by Andrey Chernyshev on 11.08.2021.
//

import UIKit

final class OGoalCell: UIView {
    var isSelected = false {
        didSet {
            shapeLayer.fillColor = isSelected ? UIColor(integralRed: 132, green: 214, blue: 218).cgColor : UIColor.white.cgColor
            titleLabel.textColor = isSelected ? UIColor.white : UIColor(integralRed: 31, green: 31, blue: 31)
        }
    }
    
    lazy var titleLabel = makeLabel()
    
    var title: String = "" {
        didSet {
            let attrs = TextAttributes()
                .textColor(UIColor(integralRed: 31, green: 31, blue: 31))
                .font(Fonts.Qanelas.regular(size: 20.scale))
                .lineHeight(28.scale)
            titleLabel.attributedText = title.attributed(with: attrs)
        }
    }
    
    private lazy var shapeLayer = CAShapeLayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        makeConstraints()
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: frame.width - 40.scale, y: 0))
        path.addLine(to: CGPoint(x: frame.width, y: frame.height))
        path.addLine(to: CGPoint(x: 0, y: frame.height))

        shapeLayer.path = path.cgPath
        shapeLayer.strokeColor = UIColor.clear.cgColor
        shapeLayer.fillColor = UIColor.white.cgColor
        
        shapeLayer.removeFromSuperlayer()
        layer.insertSublayer(shapeLayer, at: 0)
    }
}

// MARK: Private
private extension OGoalCell {
    func initialize() {
        backgroundColor = UIColor.clear
    }
}

// MARK: Make constraints
private extension OGoalCell {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16.scale),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}

// MARK: Lazy initialization
private extension OGoalCell {
    func makeLabel() -> UILabel {
        let view = UILabel()
        view.numberOfLines = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
}
