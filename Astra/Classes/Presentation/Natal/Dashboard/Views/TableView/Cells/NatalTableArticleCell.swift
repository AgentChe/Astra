//
//  NatalTableArticleCell.swift
//  Astra
//
//  Created by Andrey Chernyshev on 29.09.2021.
//

import UIKit
import Kingfisher

final class NatalTableArticleCell: UITableViewCell {
    weak var delegate: NatalTableViewDelegate?
    
    lazy var container = makeContainer()
    lazy var planetImageView = makePlanetImageView()
    lazy var titleLabel = makeLabel()
    lazy var subtitleLabel = makeLabel()
    lazy var arrowImageView = makeArrowImageView()
    
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
extension NatalTableArticleCell {
    func setup(article: NatalArticle) {
        planetImageView.image = mapImage(from: article.iconCode)
        
        titleLabel.attributedText = article.title
            .attributed(with: TextAttributes()
                            .textColor(UIColor(integralRed: 31, green: 31, blue: 31))
                            .font(Fonts.Qanelas.bold(size: 17.scale))
                            .lineHeight(21.scale))
        
        subtitleLabel.attributedText = article.subtitle
            .attributed(with: TextAttributes()
                            .textColor(UIColor(integralRed: 63, green: 63, blue: 63))
                            .font(Fonts.Qanelas.regular(size: 14.scale))
                            .lineHeight(16.6.scale))
    }
}

// MARK: Private
private extension NatalTableArticleCell {
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
private extension NatalTableArticleCell {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            container.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16.scale),
            container.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16.scale),
            container.topAnchor.constraint(equalTo: contentView.topAnchor),
            container.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            planetImageView.widthAnchor.constraint(equalToConstant: 32.scale),
            planetImageView.heightAnchor.constraint(equalToConstant: 32.scale),
            planetImageView.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 16.scale),
            planetImageView.topAnchor.constraint(equalTo: container.topAnchor, constant: 19.scale)
        ])
        
        NSLayoutConstraint.activate([
            arrowImageView.widthAnchor.constraint(equalToConstant: 24.scale),
            arrowImageView.heightAnchor.constraint(equalToConstant: 24.scale),
            arrowImageView.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -16.scale),
            arrowImageView.topAnchor.constraint(equalTo: container.topAnchor, constant: 23.scale)
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 68.scale),
            titleLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -50.scale),
            titleLabel.topAnchor.constraint(equalTo: container.topAnchor, constant: 14.scale)
        ])
        
        NSLayoutConstraint.activate([
            subtitleLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 68.scale),
            subtitleLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -50.scale),
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 3.scale),
            subtitleLabel.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -12.scale)
        ])
    }
}

// MARK: Lazy initialization
private extension NatalTableArticleCell {
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
    
    func makePlanetImageView() -> UIImageView {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(view)
        return view
    }
    
    func makeArrowImageView() -> UIImageView {
        let view = UIImageView()
        view.image = UIImage(named: "Natal.Article.Arrow")
        view.contentMode = .scaleAspectFit
        view.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(view)
        return view
    }
}
