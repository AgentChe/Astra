//
//  MeditationDashboardDailyCell.swift
//  Astra
//
//  Created by Andrey Chernyshev on 24.08.2021.
//

import UIKit
import Kingfisher

final class MeditationDashboardDailyCell: UICollectionViewCell {
    lazy var pictureImageView = makeImageView()
    lazy var titleLabel = makeLabel()
    lazy var infoLabel = makeLabel()
    
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
extension MeditationDashboardDailyCell {
    func setup(element: DailyMeditation) {
        pictureImageView.image = nil
        pictureImageView.kf.cancelDownloadTask()
        
        if let url = URL(string: element.audio.imageUrl) {
            pictureImageView.kf.setImage(with: url)
        }
        
        titleLabel.attributedText = "MeditationsDashboard.Daily.Title"
            .localized
            .attributed(with: TextAttributes()
                            .textColor(UIColor.white)
                            .font(Fonts.Qanelas.bold(size: 17.scale))
                            .lineHeight(23.8.scale))
        
        let info = String(format: "%@ • %@", element.date, element.audio.title)
        infoLabel.attributedText = info
            .attributed(with: TextAttributes()
                            .textColor(UIColor.white)
                            .font(Fonts.Qanelas.regular(size: 17.scale))
                            .lineHeight(23.8.scale))
    }
}

// MARK: Private
private extension MeditationDashboardDailyCell {
    func initialize() {
        backgroundColor = UIColor.clear
        contentView.backgroundColor = UIColor.clear
        
        let selectedView = UIView()
        selectedView.backgroundColor = UIColor.clear
        selectedBackgroundView = selectedView
    }
}

// MARK: Make constraints
private extension MeditationDashboardDailyCell {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            pictureImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            pictureImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            pictureImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            pictureImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 13.scale),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -13.scale),
            titleLabel.bottomAnchor.constraint(equalTo: infoLabel.topAnchor, constant: -2.scale)
        ])
        
        NSLayoutConstraint.activate([
            infoLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 13.scale),
            infoLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -13.scale),
            infoLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20.scale)
        ])
    }
}

// MARK: Lazy initialization
private extension MeditationDashboardDailyCell {
    func makeImageView() -> UIImageView {
        let view = UIImageView()
        view.clipsToBounds = true
        view.layer.cornerRadius = 10.scale
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
