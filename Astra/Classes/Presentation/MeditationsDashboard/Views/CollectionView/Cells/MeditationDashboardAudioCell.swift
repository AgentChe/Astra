//
//  MeditationDashboardAudioCell.swift
//  Astra
//
//  Created by Andrey Chernyshev on 25.08.2021.
//

import UIKit
import Kingfisher

final class MeditationDashboardAudioCell: UICollectionViewCell {
    lazy var pictureImageView = makeImageView()
    lazy var titleLabel = makeLabel()
    
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
extension MeditationDashboardAudioCell {
    func setup(element: MeditationAudio) {
        pictureImageView.image = nil
        pictureImageView.kf.cancelDownloadTask()
        
        if let url = URL(string: element.imageUrl) {
            pictureImageView.kf.setImage(with: url)
        }
        
        titleLabel.attributedText = element
            .title
            .attributed(with: TextAttributes()
                            .textColor(UIColor.white)
                            .font(Fonts.Qanelas.bold(size: 17.scale))
                            .lineHeight(23.8.scale))
    }
}

// MARK: Private
private extension MeditationDashboardAudioCell {
    func initialize() {
        backgroundColor = UIColor.clear
        contentView.backgroundColor = UIColor.clear
        
        let selectedView = UIView()
        selectedView.backgroundColor = UIColor.clear
        selectedBackgroundView = selectedView
    }
}

// MARK: Make constraints
private extension MeditationDashboardAudioCell {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            pictureImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            pictureImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            pictureImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            pictureImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: pictureImageView.leadingAnchor, constant: 12.scale),
            titleLabel.trailingAnchor.constraint(equalTo: pictureImageView.trailingAnchor, constant: -12.scale),
            titleLabel.bottomAnchor.constraint(equalTo: pictureImageView.bottomAnchor, constant: -20.scale)
        ])
    }
}

// MARK: Lazy initialization
private extension MeditationDashboardAudioCell {
    func makeImageView() -> UIImageView {
        let view = UIImageView()
        view.clipsToBounds = true
        view.layer.cornerRadius = 12.scale
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
        return view    }
}
