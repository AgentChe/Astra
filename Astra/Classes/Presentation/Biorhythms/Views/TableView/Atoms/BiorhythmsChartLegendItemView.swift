//
//  BiorhythmsChartLegendItemView.swift
//  Astra
//
//  Created by Andrey Chernyshev on 16.09.2021.
//

import UIKit

final class BiorhythmsChartLegendItemView: UIView {
    var title: String = "" {
        didSet {
            let attrs = TextAttributes()
                .textColor(UIColor(integralRed: 63, green: 63, blue: 63, alpha: 0.5))
                .font(Fonts.Qanelas.regular(size: 13.scale))
                .lineHeight(15.scale)
            label.attributedText = title.attributed(with: attrs)
        }
    }
    
    lazy var colorView = makeColorView()
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
private extension BiorhythmsChartLegendItemView {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            colorView.leadingAnchor.constraint(equalTo: leadingAnchor),
            colorView.centerYAnchor.constraint(equalTo: centerYAnchor),
            colorView.widthAnchor.constraint(equalToConstant: 16.scale),
            colorView.heightAnchor.constraint(equalToConstant: 3.scale)
        ])
        
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24.scale),
            label.trailingAnchor.constraint(equalTo: trailingAnchor),
            label.topAnchor.constraint(equalTo: topAnchor),
            label.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

// MARK: Lazy initialization
private extension BiorhythmsChartLegendItemView {
    func makeColorView() -> UIView {
        let view = UIView()
        view.layer.cornerRadius = 1.5.scale
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeLabel() -> UILabel {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
}
