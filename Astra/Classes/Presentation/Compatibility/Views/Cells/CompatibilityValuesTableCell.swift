//
//  CompatibilityValuesTableCell.swift
//  Astra
//
//  Created by Andrey Chernyshev on 23.08.2021.
//

import UIKit

final class CompatibilityValuesTableCell: UITableViewCell {
    lazy var container = makeContainer()
    lazy var loveTitleLabel = makeLabel()
    lazy var loveValueLabel = makeLabel()
    lazy var loveProgressView = makeProgressView()
    lazy var trustTitleLabel = makeLabel()
    lazy var trustValueLabel = makeLabel()
    lazy var trustProgressView = makeProgressView()
    lazy var emotionsTitleLabel = makeLabel()
    lazy var emotionsValueLabel = makeLabel()
    lazy var emotionsProgressView = makeProgressView()
    lazy var valuesTitleLabel = makeLabel()
    lazy var valuesValueLabel = makeLabel()
    lazy var valuesProgressView = makeProgressView()
    
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
extension CompatibilityValuesTableCell {
    func setup(values: CompatibilityValuesTableElement) {
        let titleAttrs = TextAttributes()
            .textColor(UIColor(integralRed: 31, green: 31, blue: 31))
            .lineHeight(23.8.scale)
            .font(Fonts.Qanelas.bold(size: 17.scale))
        
        let valueAttrs = TextAttributes()
            .textColor(UIColor(integralRed: 31, green: 31, blue: 31))
            .lineHeight(23.8.scale)
            .font(Fonts.Qanelas.regular(size: 17.scale))
        
        loveTitleLabel.attributedText = "Compatibility.Love".localized.attributed(with: titleAttrs)
        loveValueLabel.attributedText = String(format: "Compatibility.Percent".localized, String(values.love * 10)).attributed(with: valueAttrs)
        loveProgressView.progress = Float(values.love) / 10
        
        trustTitleLabel.attributedText = "Compatibility.Trust".localized.attributed(with: titleAttrs)
        trustValueLabel.attributedText = String(format: "Compatibility.Percent".localized, String(values.trust * 10)).attributed(with: valueAttrs)
        trustProgressView.progress = Float(values.trust) / 10
        
        emotionsTitleLabel.attributedText = "Compatibility.Emotions".localized.attributed(with: titleAttrs)
        emotionsValueLabel.attributedText = String(format: "Compatibility.Percent".localized, String(values.emotions * 10)).attributed(with: valueAttrs)
        emotionsProgressView.progress = Float(values.emotions) / 10
        
        valuesTitleLabel.attributedText = "Compatibility.Values".localized.attributed(with: titleAttrs)
        valuesValueLabel.attributedText = String(format: "Compatibility.Percent".localized, String(values.values * 10)).attributed(with: valueAttrs)
        valuesProgressView.progress = Float(values.values) / 10
    }
}

// MARK: Private
private extension CompatibilityValuesTableCell {
    func initialize() {
        backgroundColor = UIColor.clear
        contentView.backgroundColor = UIColor.clear
        
        selectionStyle = .none
    }
}

// MARK: Make constraints
private extension CompatibilityValuesTableCell {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            container.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16.scale),
            container.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16.scale),
            container.topAnchor.constraint(equalTo: contentView.topAnchor),
            container.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            loveTitleLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 18.scale),
            loveTitleLabel.topAnchor.constraint(equalTo: container.topAnchor, constant: 16.scale)
        ])
        
        NSLayoutConstraint.activate([
            loveValueLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -18.scale),
            loveValueLabel.centerYAnchor.constraint(equalTo: loveTitleLabel.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            loveProgressView.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 16.scale),
            loveProgressView.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -16.scale),
            loveProgressView.topAnchor.constraint(equalTo: loveTitleLabel.bottomAnchor, constant: 9.scale),
            loveProgressView.heightAnchor.constraint(equalToConstant: 6.scale)
        ])
        
        NSLayoutConstraint.activate([
            trustTitleLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 18.scale),
            trustTitleLabel.topAnchor.constraint(equalTo: loveProgressView.topAnchor, constant: 24.scale)
        ])
        
        NSLayoutConstraint.activate([
            trustValueLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -18.scale),
            trustValueLabel.centerYAnchor.constraint(equalTo: trustTitleLabel.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            trustProgressView.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 16.scale),
            trustProgressView.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -16.scale),
            trustProgressView.topAnchor.constraint(equalTo: trustTitleLabel.bottomAnchor, constant: 9.scale),
            trustProgressView.heightAnchor.constraint(equalToConstant: 6.scale)
        ])
        
        NSLayoutConstraint.activate([
            emotionsTitleLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 18.scale),
            emotionsTitleLabel.topAnchor.constraint(equalTo: trustProgressView.topAnchor, constant: 24.scale)
        ])
        
        NSLayoutConstraint.activate([
            emotionsValueLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -18.scale),
            emotionsValueLabel.centerYAnchor.constraint(equalTo: emotionsTitleLabel.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            emotionsProgressView.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 16.scale),
            emotionsProgressView.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -16.scale),
            emotionsProgressView.topAnchor.constraint(equalTo: emotionsTitleLabel.bottomAnchor, constant: 9.scale),
            emotionsProgressView.heightAnchor.constraint(equalToConstant: 6.scale)
        ])
        
        NSLayoutConstraint.activate([
            valuesTitleLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 18.scale),
            valuesTitleLabel.topAnchor.constraint(equalTo: emotionsProgressView.topAnchor, constant: 24.scale)
        ])
        
        NSLayoutConstraint.activate([
            valuesValueLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -18.scale),
            valuesValueLabel.centerYAnchor.constraint(equalTo: valuesTitleLabel.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            valuesProgressView.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 16.scale),
            valuesProgressView.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -16.scale),
            valuesProgressView.topAnchor.constraint(equalTo: valuesTitleLabel.bottomAnchor, constant: 9.scale),
            valuesProgressView.heightAnchor.constraint(equalToConstant: 6.scale)
        ])
    }
}

// MARK: Lazy initialization
private extension CompatibilityValuesTableCell {
    func makeContainer() -> UIView {
        let view = UIView()
        view.backgroundColor = UIColor(integralRed: 252, green: 252, blue: 252)
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.1
        view.layer.shadowOffset = .zero
        view.layer.shadowRadius = 4.scale
        view.layer.cornerRadius = 7.scale
        view.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(view)
        return view
    }
    
    func makeLabel() -> UILabel {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(view)
        return view
    }
    
    func makeProgressView() -> UIProgressView {
        let view = UIProgressView()
        view.layer.cornerRadius = 4.scale
        view.layer.masksToBounds = true
        view.tintColor = UIColor(integralRed: 233, green: 231, blue: 228)
        view.progressTintColor = UIColor(integralRed: 244, green: 157, blue: 129)
        view.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(view)
        return view
    }
}
