//
//  LunarCalendarMainTableCell.swift
//  Astra
//
//  Created by Andrey Chernyshev on 16.08.2021.
//

import UIKit

final class LunarCalendarMainTableCell: UITableViewCell {
    lazy var stackView = makeStackView()
    lazy var day1View = makeDayView()
    lazy var day2View = makeDayView()
    lazy var day3View = makeDayView()
    lazy var day4View = makeDayView()
    lazy var day5View = makeDayView()
    lazy var day6View = makeDayView()
    lazy var day7View = makeDayView()
    
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
extension LunarCalendarMainTableCell {
    func setup(element: [LunarCalendarDay]) {
        let dayViews = [
            day1View, day2View, day3View, day4View, day5View, day6View, day7View
        ]
        
        dayViews.forEach { $0.isHidden = true }
        
        for (index, day) in element.prefix(7).enumerated() {
            dayViews[index].isHidden = false
            dayViews[index].day = day
        }
    }
}

// MARK: Private
private extension LunarCalendarMainTableCell {
    func initialize() {
        backgroundColor = UIColor.clear
        contentView.backgroundColor = UIColor.clear
        
        selectionStyle = .none
    }
}

// MARK: Make constraints
private extension LunarCalendarMainTableCell {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16.scale),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16.scale),
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}

// MARK: Lazy initialization
private extension LunarCalendarMainTableCell {
    func makeStackView() -> UIStackView {
        let view = UIStackView()
        view.axis = .horizontal
        view.distribution = .equalSpacing
        view.spacing = 17.scale
        view.backgroundColor = UIColor.clear
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeDayView() -> LunarDayView {
        let view = LunarDayView()
        view.layer.cornerRadius = 4.scale
        view.layer.masksToBounds  = true
        view.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(view)
        return view
    }
}
