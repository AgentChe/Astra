//
//  MeditationsFilterCollectionCell.swift
//  Astra
//
//  Created by Andrey Chernyshev on 24.08.2021.
//

import UIKit

final class MeditationsFilterCollectionCell: UICollectionViewCell {
    lazy var titleLabel = makeTitleLabel()
    lazy var separator = makeSeparator()
    
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
extension MeditationsFilterCollectionCell {
    static func calculateWidth(code: MeditationsFilterCollectionElement.Code) -> CGFloat {
        let attrs = TextAttributes()
            .font(Fonts.Qanelas.regular(size: 19.scale))
            .lineHeight(22.8.scale)
        let string = title(at: code).attributed(with: attrs)
        return string.size().width + 16.scale
    }
    
    func setup(element: MeditationsFilterCollectionElement) {
        let attrs = TextAttributes()
            .textColor(element.isSelected ? UIColor(integralRed: 255, green: 141, blue: 91) : UIColor(integralRed: 63, green: 63, blue: 63))
            .font(Fonts.Qanelas.regular(size: 19.scale))
            .lineHeight(22.8.scale)
            .textAlignment(.center)
        titleLabel.attributedText = Self.title(at: element.code).attributed(with: attrs)
    
        separator.isHidden = !element.isSelected
    }
}

// MARK: Private
private extension MeditationsFilterCollectionCell {
    static func title(at code: MeditationsFilterCollectionElement.Code) -> String {
        switch code {
        case .all:
            return "MeditationsDashboard.Filter.All".localized
        case .courses:
            return "MeditationsDashboard.Filter.Courses".localized
        case .another(let title):
            return title
        }
    }
    
    func initialize() {
        backgroundColor = UIColor.clear
        contentView.backgroundColor = UIColor.clear
        
        let selectedView = UIView()
        selectedView.backgroundColor = UIColor.clear
        selectedBackgroundView = selectedView
    }
}

// MARK: Make constraints
private extension MeditationsFilterCollectionCell {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor)
        ])
        
        NSLayoutConstraint.activate([
            separator.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            separator.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            separator.heightAnchor.constraint(equalToConstant: 3.scale),
            separator.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}

// MARK: Lazy initialization
private extension MeditationsFilterCollectionCell {
    func makeTitleLabel() -> UILabel {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(view)
        return view
    }
    
    func makeSeparator() -> UIView {
        let view = UIView()
        view.backgroundColor = UIColor(integralRed: 255, green: 141, blue: 91)
        view.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(view)
        return view
    }
}
