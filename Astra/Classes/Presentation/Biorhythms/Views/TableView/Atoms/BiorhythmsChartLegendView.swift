//
//  BiorhythmsChartLegendView.swift
//  Astra
//
//  Created by Andrey Chernyshev on 16.09.2021.
//

import UIKit

final class BiorhythmsChartLegendView: UIView {
    lazy var physicalItem = makeItemView(color: UIColor(integralRed: 121, green: 155, blue: 202),
                                         name: "Biorhythms.Physical".localized.lowercased())
    lazy var emotionalItem = makeItemView(color: UIColor(integralRed: 234, green: 140, blue: 140),
                                          name: "Biorhythms.Emotional".localized.lowercased())
    lazy var intellectualItem = makeItemView(color: UIColor(integralRed: 253, green: 240, blue: 173),
                                             name: "Biorhythms.Intellectual".localized.lowercased())
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Make constraints
private extension BiorhythmsChartLegendView {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            physicalItem.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 72.scale),
            physicalItem.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            emotionalItem.leadingAnchor.constraint(equalTo: physicalItem.trailingAnchor, constant: 20.scale),
            emotionalItem.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            intellectualItem.leadingAnchor.constraint(equalTo: emotionalItem.trailingAnchor, constant: 20.scale),
            intellectualItem.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}

// MARK: Lazy initialization
private extension BiorhythmsChartLegendView {
    func makeItemView(color: UIColor, name: String) -> BiorhythmsChartLegendItemView {
        let view = BiorhythmsChartLegendItemView()
        view.backgroundColor = UIColor.clear
        view.colorView.backgroundColor = color
        view.title = name
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
}
