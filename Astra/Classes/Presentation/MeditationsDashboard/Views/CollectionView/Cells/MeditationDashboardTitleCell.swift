//
//  MeditationDashboardTitleCell.swift
//  Astra
//
//  Created by Andrey Chernyshev on 24.08.2021.
//

import UIKit

final class MeditationDashboardTitleCell: UICollectionViewCell {
    lazy var titleLabel = makeTitleLabel()
    
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
extension MeditationDashboardTitleCell {
    static func calculateHeight(width: CGFloat, string: String) -> CGFloat {
        let attrs = TextAttributes()
            .font(Fonts.Qanelas.bold(size: 24.scale))
            .lineHeight(28.8.scale)
        
        let attrsString = string.attributed(with: attrs)
        
        let rect = attrsString.boundingRect(with: CGSize(width: width, height: CGFloat.greatestFiniteMagnitude),
                                            options: [.usesFontLeading, .usesLineFragmentOrigin],
                                            context: nil)
        
        return rect.height
    }
    
    func setup(element: String) {
        let attrs = TextAttributes()
            .textColor(UIColor(integralRed: 31, green: 31, blue: 31))
            .font(Fonts.Qanelas.bold(size: 24.scale))
            .lineHeight(28.8.scale)
        titleLabel.attributedText = element.attributed(with: attrs)
    }
}

// MARK: Private
private extension MeditationDashboardTitleCell {
    func initialize() {
        backgroundColor = UIColor.clear
        contentView.backgroundColor = UIColor.clear
        
        let selectedView = UIView()
        selectedView.backgroundColor = UIColor.clear
        selectedBackgroundView = selectedView
    }
}

// MARK: Make constraints
private extension MeditationDashboardTitleCell {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20.scale),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20.scale),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor)
        ])
    }
}

// MARK: Lazy initialization
private extension MeditationDashboardTitleCell {
    func makeTitleLabel() -> UILabel {
        let view = UILabel()
        view.numberOfLines = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(view)
        return view
    }
}
