//
//  ChartClosedMainTableCell.swift
//  Astra
//
//  Created by Andrey Chernyshev on 16.08.2021.
//

import UIKit

final class ChartClosedMainTableCell: UITableViewCell {
    lazy var container = makeContainer()
    lazy var planetImageView = makePlanetImageView()
    lazy var titleLabel = makeLabel()
    lazy var dateLabel = makeLabel()
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
extension ChartClosedMainTableCell {
    func setup(element: ChartMainTableElement) {
        let chart = element.chart
        
        planetImageView.image = mapImage(from: chart.iconCode)
        
        titleLabel.attributedText = chart.title
            .attributed(with: TextAttributes()
                            .textColor(UIColor(integralRed: 31, green: 31, blue: 31))
                            .font(Fonts.Qanelas.bold(size: 17.scale))
                            .lineHeight(21.scale))
        
        dateLabel.attributedText = chart.date
            .attributed(with: TextAttributes()
                            .textColor(UIColor(integralRed: 63, green: 63, blue: 63))
                            .font(Fonts.Qanelas.regular(size: 14.scale))
                            .lineHeight(16.6.scale))
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

// MARK: Private
private extension ChartClosedMainTableCell {
    func initialize() {
        backgroundColor = UIColor.clear
        contentView.backgroundColor = UIColor.clear
        
        selectionStyle = .none
    }
}

// MARK: Make constraints
private extension ChartClosedMainTableCell {
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
            dateLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 68.scale),
            dateLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -50.scale),
            dateLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 3.scale),
            dateLabel.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -12.scale)
        ])
    }
}

// MARK: Lazy initialization
private extension ChartClosedMainTableCell {
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
        view.image = UIImage(named: "Main.Chart.ArrowDown")
        view.contentMode = .scaleAspectFit
        view.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(view)
        return view
    }
}
