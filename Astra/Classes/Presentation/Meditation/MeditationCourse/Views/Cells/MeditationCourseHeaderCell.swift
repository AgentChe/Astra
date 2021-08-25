//
//  MeditationCourseHeaderCell.swift
//  Astra
//
//  Created by Andrey Chernyshev on 25.08.2021.
//

import UIKit

final class MeditationCourseHeaderCell: UITableViewCell {
    lazy var pictureView = makeImageView()
    lazy var titleLabel = makeLabel()
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
extension MeditationCourseHeaderCell {
    func setup(imagePath: String, title: String, info: String) {
        pictureView.image = nil
        pictureView.kf.cancelDownloadTask()
        
        if let url = URL(string: imagePath) {
            pictureView.kf.setImage(with: url)
        }

        titleLabel.attributedText = title
            .attributed(with: TextAttributes()
                            .textColor(UIColor.white)
                            .font(Fonts.Qanelas.bold(size: 17.scale))
                            .lineHeight(23.8.scale))

        descriptionLabel.attributedText = info
            .attributed(with: TextAttributes()
                            .textColor(UIColor.white)
                            .font(Fonts.Qanelas.regular(size: 17.scale))
                            .lineHeight(23.8.scale))
    }
}

// MARK: Private
private extension MeditationCourseHeaderCell {
    func initialize() {
        backgroundColor = UIColor.clear
        contentView.backgroundColor = UIColor.clear
        
        selectionStyle = .none
    }
}

// MARK: Make constraints
private extension MeditationCourseHeaderCell {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            pictureView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            pictureView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            pictureView.topAnchor.constraint(equalTo: contentView.topAnchor),
            pictureView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20.scale),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20.scale),
            titleLabel.bottomAnchor.constraint(equalTo: descriptionLabel.topAnchor, constant: -2.scale)
        ])
        
        NSLayoutConstraint.activate([
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20.scale),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20.scale),
            descriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16.scale)
        ])
    }
}

// MARK: Lazy initialization
private extension MeditationCourseHeaderCell {
    func makeImageView() -> UIImageView {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
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
