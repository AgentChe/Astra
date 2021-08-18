//
//  LunarDayView.swift
//  Astra
//
//  Created by Andrey Chernyshev on 16.08.2021.
//

final class LunarDayView: UIView {
    lazy var circle1Color: UIColor = UIColor(integralRed: 241, green: 240, blue: 238) {
        didSet {
            circle1View.backgroundColor = circle1Color
        }
    }
    
    lazy var circle2Color: UIColor = UIColor(integralRed: 63, green: 63, blue: 63) {
        didSet {
            circle2View.backgroundColor = circle2Color
        }
    }
    
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
    lazy var circle1View = makeCircle1View()
    lazy var circle2View = makeCircle2View()
    
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
        
        circle1View.backgroundColor = circle1Color
        circle2View.backgroundColor = circle2Color
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

        let one = 24.scale / 15
        let x = CGFloat(day.offset) * one 
        circle2View.frame.origin.x = x
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
    
    func makeCircle1View() -> CircleView {
        let view = CircleView()
        view.layer.masksToBounds = true
        view.frame.origin = CGPoint(x: 5.scale, y: 36.scale)
        view.frame.size = CGSize(width: 24.scale, height: 24.scale)
        addSubview(view)
        return view
    }
    
    func makeCircle2View() -> CircleView {
        let view = CircleView()
        view.frame.origin = CGPoint(x: 0.scale, y: 0.scale)
        view.frame.size = CGSize(width: 24.scale, height: 24.scale)
        circle1View.addSubview(view)
        return view
    }
}
