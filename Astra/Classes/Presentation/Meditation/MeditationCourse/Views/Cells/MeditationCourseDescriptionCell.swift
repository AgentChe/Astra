//
//  MeditationCourseDescriptionCell.swift
//  Astra
//
//  Created by Andrey Chernyshev on 25.08.2021.
//

import UIKit

final class MeditationCourseDescriptionCell: UITableViewCell {
    lazy var titleLabel = makeTitleLabel()
    lazy var descriptionLabel = makeLabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        makeConstraints()
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Public
extension MeditationCourseDescriptionCell {
    func setup(description: String) {
        descriptionLabel.attributedText = description
            .attributed(with: TextAttributes()
                            .textColor(UIColor(integralRed: 63, green: 63, blue: 63))
                            .font(Fonts.Qanelas.regular(size: 17.scale))
                            .lineHeight(23.8.scale))
    }
}

// MARK: Private
private extension MeditationCourseDescriptionCell {
    func initialize() {
        backgroundColor = UIColor.clear
        contentView.backgroundColor = UIColor.clear
        
        selectionStyle = .none
    }
}

// MARK: Make constraints
private extension MeditationCourseDescriptionCell {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20.scale),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20.scale),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor)
        ])
        
        NSLayoutConstraint.activate([
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20.scale),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20.scale),
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12.scale),
            descriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}

// MARK: Lazy initialization
private extension MeditationCourseDescriptionCell {
    func makeTitleLabel() -> UILabel {
        let attrs = TextAttributes()
            .textColor(UIColor(integralRed: 63, green: 63, blue: 63, alpha: 0.5))
            .font(Fonts.Qanelas.bold(size: 14.scale))
            .lineHeight(19.6.scale)
        
        let view = UILabel()
        view.attributedText = "MeditationCourse.Course".localized.attributed(with: attrs)
        view.numberOfLines = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(view)
        return view
    }
    
    func makeLabel() -> UILabel {
        let view = UILabel()
        view.numberOfLines = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(view)
        return view
    }
}
