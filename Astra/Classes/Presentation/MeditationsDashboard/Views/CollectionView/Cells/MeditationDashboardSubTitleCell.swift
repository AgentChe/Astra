//
//  MeditationDashboardSubTitleCell.swift
//  Astra
//
//  Created by Andrey Chernyshev on 25.08.2021.
//

import UIKit

final class MeditationDashboardSubTitleCell: UICollectionViewCell {
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
extension MeditationDashboardSubTitleCell {
    static func calculateHeight(width: CGFloat, string: String) -> CGFloat {
        let attrs = TextAttributes()
            .font(Fonts.Qanelas.regular(size: 17.scale))
            .lineHeight(23.8.scale)
        
        let attrsString = string.attributed(with: attrs)
        
        let rect = attrsString.boundingRect(with: CGSize(width: width, height: CGFloat.greatestFiniteMagnitude),
                                            options: [.usesFontLeading, .usesLineFragmentOrigin],
                                            context: nil)
        
        return rect.height
    }
    
    func setup(element: String) {
        let attrs = TextAttributes()
            .textColor(UIColor(integralRed: 63, green: 63, blue: 63))
            .font(Fonts.Qanelas.regular(size: 17.scale))
            .lineHeight(23.8.scale)
        titleLabel.attributedText = element.attributed(with: attrs)
    }
}

// MARK: Private
private extension MeditationDashboardSubTitleCell {
    func initialize() {
        backgroundColor = UIColor.clear
        contentView.backgroundColor = UIColor.clear
        
        let selectedView = UIView()
        selectedView.backgroundColor = UIColor.clear
        selectedBackgroundView = selectedView
    }
}

// MARK: Make constraints
private extension MeditationDashboardSubTitleCell {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20.scale),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20.scale),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor)
        ])
    }
}

// MARK: Lazy initialization
private extension MeditationDashboardSubTitleCell {
    func makeTitleLabel() -> UILabel {
        let view = UILabel()
        view.numberOfLines = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(view)
        return view
    }
}
