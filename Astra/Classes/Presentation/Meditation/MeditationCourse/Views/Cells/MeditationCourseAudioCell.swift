//
//  MeditationCourseAudioCell.swift
//  Astra
//
//  Created by Andrey Chernyshev on 25.08.2021.
//

import UIKit

final class MeditationCourseAudioCell: UITableViewCell {
    lazy var numberLabel = makeNumberLabel()
    lazy var titleLabel = makeLabel()
    lazy var minutesLabel = makeLabel()
    lazy var separator = makeSeparator()
    
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
extension MeditationCourseAudioCell {
    func setup(element: MeditationCourseAudioElement) {
        numberLabel.attributedText = String(element.number)
            .attributed(with: TextAttributes()
                            .textColor(UIColor(integralRed: 63, green: 63, blue: 63))
                            .font(Fonts.Qanelas.bold(size: 17.scale))
                            .lineHeight(23.8.scale)
                            .textAlignment(.center))
        
        titleLabel.attributedText = element
            .audio.title
            .attributed(with: TextAttributes()
                            .textColor(UIColor(integralRed: 31, green: 31, blue: 31))
                            .font(Fonts.Qanelas.bold(size: 17.scale))
                            .lineHeight(23.8.scale))
        
        let minutes = element.audio.duration / 60
        minutesLabel.attributedText = String(format: "MeditationCourse.Min".localized, minutes)
            .attributed(with: TextAttributes()
                            .textColor(UIColor(integralRed: 63, green: 63, blue: 63, alpha: 0.5))
                            .font(Fonts.Qanelas.bold(size: 14.scale))
                            .lineHeight(19.6.scale))
    }
}

// MARK: Private
private extension MeditationCourseAudioCell {
    func initialize() {
        backgroundColor = UIColor.clear
        contentView.backgroundColor = UIColor.clear
        
        selectionStyle = .none
    }
}

// MARK: Make constraints
private extension MeditationCourseAudioCell {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            numberLabel.widthAnchor.constraint(equalToConstant: 40.scale),
            numberLabel.heightAnchor.constraint(equalToConstant: 40.scale),
            numberLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20.scale),
            numberLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 80.scale),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20.scale),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor)
        ])
        
        NSLayoutConstraint.activate([
            minutesLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 80.scale),
            minutesLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20.scale),
            minutesLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            minutesLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15.scale)
        ])
        
        NSLayoutConstraint.activate([
            separator.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20.scale),
            separator.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20.scale),
            separator.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            separator.heightAnchor.constraint(equalToConstant: 1.scale)
        ])
    }
}

// MARK: Lazy initialization
private extension MeditationCourseAudioCell {
    func makeNumberLabel() -> UILabel {
        let view = UILabel()
        view.backgroundColor = UIColor(integralRed: 233, green: 231, blue: 228)
        view.layer.cornerRadius = 20.scale
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
    
    func makeSeparator() -> UIView {
        let view = UIView()
        view.backgroundColor = UIColor(integralRed: 233, green: 231, blue: 228)
        view.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(view)
        return view
    }
}
