//
//  HoroFilterButton.swift
//  Astra
//
//  Created by Andrey Chernyshev on 15.08.2021.
//

import UIKit

final class HoroFilterCollectionCell: UICollectionViewCell {
    lazy var label = makeLabel()
    lazy var selector = makeSelector()
    
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
extension HoroFilterCollectionCell {
    func setup(filter: HoroFilterTableElement) {
        let attrs = TextAttributes()
            .textColor(filter.isSelected ? UIColor(integralRed: 255, green: 141, blue: 91) : UIColor(integralRed: 63, green: 63, blue: 63))
            .font(Fonts.Qanelas.regular(size: 19.scale))
            .lineHeight(22.8.scale)
        label.attributedText = filter.title.attributed(with: attrs)
        
        selector.isHidden = !filter.isSelected
    }
}

// MARK: Private
private extension HoroFilterCollectionCell {
    func initialize() {
        backgroundColor = UIColor.clear
        contentView.backgroundColor = UIColor.clear
        
        let view = UIView()
        view.backgroundColor = UIColor.clear
        selectedBackgroundView = view
    }
}

// MARK: Make constraints
private extension HoroFilterCollectionCell {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            label.topAnchor.constraint(equalTo: contentView.topAnchor)
        ])
        
        NSLayoutConstraint.activate([
            selector.leadingAnchor.constraint(equalTo: label.leadingAnchor),
            selector.trailingAnchor.constraint(equalTo: label.trailingAnchor),
            selector.heightAnchor.constraint(equalToConstant: 3.scale),
            selector.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}

// MARK: Lazy initialization
private extension HoroFilterCollectionCell {
    func makeLabel() -> UILabel {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(view)
        return view
    }
    
    func makeSelector() -> UIView {
        let view = UIView()
        view.backgroundColor = UIColor(integralRed: 255, green: 141, blue: 91)
        view.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(view)
        return view
    }
}
