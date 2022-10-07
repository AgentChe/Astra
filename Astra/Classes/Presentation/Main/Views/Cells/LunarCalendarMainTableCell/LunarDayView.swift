//
//  LunarDayView.swift
//  Astra
//
//  Created by Andrey Chernyshev on 16.08.2021.
//

import UIKit

final class LunarDayView: UIView {
    lazy var textColorHighlighted: UIColor = UIColor.white {
        didSet {
            update()
        }
    }
    
    lazy var dayColor: UIColor = UIColor(integralRed: 63, green: 63, blue: 63) {
        didSet {
            update()
        }
    }
    
    lazy var numberColor: UIColor = UIColor(integralRed: 63, green: 63, blue: 63) {
        didSet {
            update()
        }
    }
    
    lazy var dayLabel = makeLabel()
    lazy var numberLabel = makeLabel()
    lazy var iconView = makeIconView()
    
    var day: LunarCalendarDay? {
        didSet {
            update()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        makeConstraints()
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var intrinsicContentSize: CGSize {
        CGSize(width: 34.scale, height: 100.scale)
    }
}

// MARK: Private
private extension LunarDayView {
    func initialize() {
        layer.masksToBounds = true
    }
    
    func update() {
        guard let day = day else {
            return
        }
        
        backgroundColor = day.highlighted ? UIColor(integralRed: 255, green: 141, blue: 91) : UIColor.clear
        
        dayLabel.attributedText = day.code
            .attributed(with: TextAttributes()
                            .textColor(day.highlighted ? textColorHighlighted : dayColor)
                            .font(Fonts.Qanelas.regular(size: 14.scale))
                            .lineHeight(19.6.scale))
        
        numberLabel.attributedText = day.number
            .attributed(with: TextAttributes()
                            .textColor(day.highlighted ? textColorHighlighted : numberColor)
                            .font(Fonts.Qanelas.regular(size: 14.scale))
                            .lineHeight(19.6.scale))
        
        let imageName = String(format: "Lunar.Offset.%i", day.offset)
        iconView.image = UIImage(named: imageName)
    }
}

// MARK: Make constraints
private extension LunarDayView {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            dayLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            dayLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8.scale)
        ])
        
        NSLayoutConstraint.activate([
            numberLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            numberLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8.scale)
        ])
        
        NSLayoutConstraint.activate([
            iconView.widthAnchor.constraint(equalToConstant: 24.scale),
            iconView.heightAnchor.constraint(equalToConstant: 24.scale),
            iconView.centerXAnchor.constraint(equalTo: centerXAnchor),
            iconView.topAnchor.constraint(equalTo: topAnchor, constant: 36.scale)
        ])
    }
}

// MARK: Lazy initialization
private extension LunarDayView {
    func makeLabel() -> UILabel {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeIconView() -> UIImageView {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
}
