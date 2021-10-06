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
    lazy var shadowView = makeShadowView()
    lazy var titleLabel = makeLabel()
    lazy var lockView = makeLockView()
    
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
    func setup(element: MeditationDashboardCollectionAudioElement) {
        pictureImageView.image = nil
        pictureImageView.kf.cancelDownloadTask()
        
        lockView.isHidden = !element.needPayment
        
        if let url = URL(string: element.audio.imageUrl) {
            pictureImageView.kf.setImage(with: url)
        }
        
        titleLabel.attributedText = element
            .audio.title
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
            shadowView.leadingAnchor.constraint(equalTo: pictureImageView.leadingAnchor),
            shadowView.trailingAnchor.constraint(equalTo: pictureImageView.trailingAnchor),
            shadowView.topAnchor.constraint(equalTo: pictureImageView.topAnchor),
            shadowView.bottomAnchor.constraint(equalTo: pictureImageView.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: pictureImageView.leadingAnchor, constant: 12.scale),
            titleLabel.trailingAnchor.constraint(equalTo: pictureImageView.trailingAnchor, constant: -12.scale),
            titleLabel.bottomAnchor.constraint(equalTo: pictureImageView.bottomAnchor, constant: -20.scale)
        ])
        
        NSLayoutConstraint.activate([
            lockView.widthAnchor.constraint(equalToConstant: 34.scale),
            lockView.heightAnchor.constraint(equalToConstant: 34.scale),
            lockView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16.scale),
            lockView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16.scale)
        ])
    }
}

// MARK: Lazy initialization
private extension MeditationDashboardAudioCell {
    func makeImageView() -> UIImageView {
        let view = UIImageView()
        view.backgroundColor = UIColor(integralRed: 227, green: 225, blue: 221)
        view.clipsToBounds = true
        view.layer.cornerRadius = 12.scale
        view.contentMode = .scaleAspectFill
        view.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(view)
        return view
    }
    
    func makeShadowView() -> GradientView {
        let view = GradientView()
        view.gradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
        view.gradientLayer.endPoint = CGPoint(x: 0.5, y: 1)
        view.gradientLayer.colors = [
            UIColor.black.withAlphaComponent(0.2).cgColor,
            UIColor.black.withAlphaComponent(0.4).cgColor
        ]
        view.layer.cornerRadius = 10.scale
        view.layer.masksToBounds = true
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
    
    func makeLockView() -> UIImageView {
        let view = UIImageView()
        view.image = UIImage(named: "Meditation.Lock")
        view.contentMode = .scaleAspectFit
        view.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(view)
        return view
    }
}
