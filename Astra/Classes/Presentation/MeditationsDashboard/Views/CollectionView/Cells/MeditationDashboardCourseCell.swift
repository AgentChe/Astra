//
//  MeditationDashboardCourseCell.swift
//  Astra
//
//  Created by Andrey Chernyshev on 25.08.2021.
//

import UIKit
import Kingfisher

final class MeditationDashboardCourseCell: UICollectionViewCell {
    lazy var container = makeContainer()
    lazy var pictureImageView = makeImageView()
    lazy var countLabel = makeCountLabel()
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
extension MeditationDashboardCourseCell {
    static func calculateHeight(width: CGFloat, course: MeditationCourse) -> CGFloat {
        let pictureHeight = 175.scale
        let allVerticalMargins = 8.scale + 2.scale + 12.scale
        
        let titleAttrs = TextAttributes()
            .font(Fonts.Qanelas.bold(size: 17.scale))
            .lineHeight(23.8.scale)
        let title = course.title.attributed(with: titleAttrs)
        let titleRect = title
            .boundingRect(with: CGSize(width: width,
                                       height: CGFloat.greatestFiniteMagnitude),
                          options: [.usesFontLeading, .usesLineFragmentOrigin],
                          context: nil)
        let titleHeight = titleRect.height
        
        let infoAttrs = TextAttributes()
            .font(Fonts.Qanelas.regular(size: 17.scale))
            .lineHeight(23.8.scale)
        let info = course.description.attributed(with: infoAttrs)
        let infoRect = info
            .boundingRect(with: CGSize(width: width,
                                       height: CGFloat.greatestFiniteMagnitude),
                          options: [.usesFontLeading, .usesLineFragmentOrigin],
                          context: nil)
        let infoHeight = infoRect.height

        return pictureHeight + allVerticalMargins + titleHeight + infoHeight
    }
    
    func setup(element: MeditationCourse) {
        pictureImageView.image = nil
        pictureImageView.kf.cancelDownloadTask()
        
        if let url = URL(string: element.imageUrl) {
            pictureImageView.kf.setImage(with: url)
        }
        
        countLabel.attributedText = String(format: "MeditationsDashboard.Courses.Count".localized, element.count)
            .attributed(with: TextAttributes()
                            .textColor(UIColor.white)
                            .font(Fonts.Qanelas.bold(size: 17.scale)))
        
        titleLabel.attributedText = element
            .title
            .attributed(with: TextAttributes()
                            .textColor(UIColor(integralRed: 31, green: 31, blue: 31))
                            .font(Fonts.Qanelas.bold(size: 17.scale))
                            .lineHeight(23.8.scale))
        
        infoLabel.attributedText = element
            .description
            .attributed(with: TextAttributes()
                            .textColor(UIColor(integralRed: 63, green: 63, blue: 63))
                            .font(Fonts.Qanelas.regular(size: 17.scale))
                            .lineHeight(23.8.scale))
    }
}

// MARK: Private
private extension MeditationDashboardCourseCell {
    func initialize() {
        backgroundColor = UIColor.clear
        contentView.backgroundColor = UIColor.clear
        
        let selectedView = UIView()
        selectedView.backgroundColor = UIColor.clear
        selectedBackgroundView = selectedView
    }
}

// MARK: Make constraints
private extension MeditationDashboardCourseCell {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            container.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16.scale),
            container.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16.scale),
            container.topAnchor.constraint(equalTo: contentView.topAnchor),
            container.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            pictureImageView.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            pictureImageView.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            pictureImageView.topAnchor.constraint(equalTo: container.topAnchor),
            pictureImageView.heightAnchor.constraint(equalToConstant: 175.scale)
        ])
        
        NSLayoutConstraint.activate([
            countLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -16.scale),
            countLabel.topAnchor.constraint(equalTo: container.topAnchor, constant: 16.scale)
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 12.scale),
            titleLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -12.scale),
            titleLabel.topAnchor.constraint(equalTo: pictureImageView.bottomAnchor, constant: 8.scale)
        ])
        
        NSLayoutConstraint.activate([
            infoLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 12.scale),
            infoLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -12.scale),
            infoLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 2.scale)
        ])
    }
}

// MARK: Lazy initialization
private extension MeditationDashboardCourseCell {
    func makeContainer() -> UIView {
        let view = UIView()
        view.backgroundColor = UIColor(integralRed: 252, green: 252, blue: 252)
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.1
        view.layer.shadowOffset = .zero
        view.layer.shadowRadius = 4.scale
        view.layer.cornerRadius = 10.scale
        view.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(view)
        return view
    }
    
    func makeImageView() -> UIImageView {
        let view = UIImageView()
        view.clipsToBounds = true
        view.layer.cornerRadius = 10.scale
        view.contentMode = .scaleAspectFill
        view.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(view)
        return view
    }
    
    func makeCountLabel() -> PaddingLabel {
        let view = PaddingLabel()
        view.leftInset = 10.scale
        view.rightInset = 10.scale
        view.topInset = 2.scale
        view.bottomInset = 2.scale
        view.backgroundColor = UIColor.white.withAlphaComponent(0.2)
        view.layer.cornerRadius = 7.scale
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(view)
        return view
    }
    
    func makeLabel() -> UILabel {
        let view = UILabel()
        view.numberOfLines = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(view)
        return view
    }
}
