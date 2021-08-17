//
//  HoroArticleOpenedTableCell.swift
//  Astra
//
//  Created by Andrey Chernyshev on 17.08.2021.
//

import UIKit

final class HoroArticleOpenedTableCell: UITableViewCell {
    lazy var container = makeContainer()
    lazy var iconView = makeIconView()
    lazy var titleLabel = makeLabel()
    lazy var arrowImageView = makeArrowImageView()
    lazy var label = makeLabel()
    
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
extension HoroArticleOpenedTableCell {
    func setup(element: HoroContent) {
        iconView.image = mapImage(from: element.iconCode)
        
        titleLabel.attributedText = element.type
            .attributed(with: TextAttributes()
                            .textColor(UIColor(integralRed: 31, green: 31, blue: 31))
                            .font(Fonts.Qanelas.bold(size: 17.scale))
                            .lineHeight(23.8.scale))
        
        label.attributedText = element.text
            .attributed(with: TextAttributes()
                            .textColor(UIColor(integralRed: 63, green: 63, blue: 63))
                            .font(Fonts.Qanelas.regular(size: 17.scale))
                            .lineHeight(23.8.scale))
    }
    
    func mapImage(from code: Int) -> UIImage? {
        switch code {
        case 1:
            return UIImage(named: "Horo.General")
        case 2:
            return UIImage(named: "Horo.Career")
        case 3:
            return UIImage(named: "Horo.Love")
        case 4:
            return UIImage(named: "Horo.Finance")
        default:
            return nil
        }
    }
}

// MARK: Private
private extension HoroArticleOpenedTableCell {
    func initialize() {
        backgroundColor = UIColor.clear
        contentView.backgroundColor = UIColor.clear
        
        selectionStyle = .none
    }
}

// MARK: Make constraints
private extension HoroArticleOpenedTableCell {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            container.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16.scale),
            container.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16.scale),
            container.topAnchor.constraint(equalTo: contentView.topAnchor),
            container.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            iconView.widthAnchor.constraint(equalToConstant: 24.scale),
            iconView.heightAnchor.constraint(equalToConstant: 24.scale),
            iconView.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 12.scale),
            iconView.topAnchor.constraint(equalTo: container.topAnchor, constant: 18.scale)
        ])
        
        NSLayoutConstraint.activate([
            arrowImageView.widthAnchor.constraint(equalToConstant: 24.scale),
            arrowImageView.heightAnchor.constraint(equalToConstant: 24.scale),
            arrowImageView.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -16.scale),
            arrowImageView.topAnchor.constraint(equalTo: container.topAnchor, constant: 18.scale)
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 44.scale),
            titleLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -50.scale),
            titleLabel.topAnchor.constraint(equalTo: container.topAnchor, constant: 18.scale)
        ])
        
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 12.scale),
            label.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -12.scale),
            label.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 17.scale),
            label.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -16.scale)
        ])
    }
}

// MARK: Lazy initialization
private extension HoroArticleOpenedTableCell {
    func makeContainer() -> UIView {
        let view = UIView()
        view.backgroundColor = UIColor(integralRed: 252, green: 252, blue: 252)
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.1
        view.layer.shadowOffset = .zero
        view.layer.shadowRadius = 4.scale
        view.layer.cornerRadius = 4.scale
        view.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(view)
        return view
    }
    
    func makeLabel() -> UILabel {
        let view = UILabel()
        view.numberOfLines = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(view)
        return view
    }
    
    func makeIconView() -> UIImageView {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(view)
        return view
    }
    
    func makeArrowImageView() -> UIImageView {
        let view = UIImageView()
        view.image = UIImage(named: "Main.Chart.ArrowUp")
        view.contentMode = .scaleAspectFit
        view.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(view)
        return view
    }
}
