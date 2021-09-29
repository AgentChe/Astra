//
//  NatalDetailsTableTitleCell.swift
//  Astra
//
//  Created by Andrey Chernyshev on 29.09.2021.
//

import UIKit

final class NatalDetailsTableTitleCell: UITableViewCell {
    lazy var planetImageView = makePlanetImageView()
    lazy var titleLabel = makeLabel()
    lazy var subtitleLabel = makeLabel()
    
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
extension NatalDetailsTableTitleCell {
    func setup(article: NatalArticle) {
        planetImageView.image = mapImage(from: article.iconCode)
        
        titleLabel.attributedText = article.title
            .attributed(with: TextAttributes()
                            .textColor(UIColor(integralRed: 31, green: 31, blue: 31))
                            .font(Fonts.Qanelas.bold(size: 17.scale))
                            .lineHeight(23.8.scale))
        
        subtitleLabel.attributedText = article.subtitle
            .attributed(with: TextAttributes()
                            .textColor(UIColor(integralRed: 255, green: 141, blue: 91))
                            .font(Fonts.Qanelas.regular(size: 17.scale))
                            .lineHeight(23.8.scale))
    }
}

// MARK: Private
private extension NatalDetailsTableTitleCell {
    func initialize() {
        backgroundColor = UIColor.clear
        contentView.backgroundColor = UIColor.clear
        
        selectionStyle = .none
    }
    
    func mapImage(from code: Int) -> UIImage? {
        switch code {
        case 1:
            return UIImage(named: "Main.Chart.Pluto")
        case 2:
            return UIImage(named: "Main.Chart.Saturn")
        case 3:
            return UIImage(named: "Main.Chart.Uranus")
        case 4:
            return UIImage(named: "Main.Chart.Jupiter")
        case 5:
            return UIImage(named: "Main.Chart.Neptun")
        case 6:
            return UIImage(named: "Main.Chart.Mars")
        case 7:
            return UIImage(named: "Main.Chart.Sun")
        case 8:
            return UIImage(named: "Main.Chart.Moon")
        case 9:
            return UIImage(named: "Main.Chart.Mercury")
        case 10:
            return UIImage(named: "Main.Chart.Venus")
        case 11:
            return UIImage(named: "Main.Chart.Rising")
        default:
            return nil
        }
    }
}

// MARK: Make constraints
private extension NatalDetailsTableTitleCell {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            planetImageView.widthAnchor.constraint(equalToConstant: 40.scale),
            planetImageView.heightAnchor.constraint(equalToConstant: 40.scale),
            planetImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20.scale),
            planetImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 6.scale)
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 72.scale),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16.scale),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor)
        ])
        
        NSLayoutConstraint.activate([
            subtitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 72.scale),
            subtitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16.scale),
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 2.scale),
            subtitleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}

// MARK: Lazy initialization
private extension NatalDetailsTableTitleCell {
    func makePlanetImageView() -> UIImageView {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
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
