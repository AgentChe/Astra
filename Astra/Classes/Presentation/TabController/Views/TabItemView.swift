//
//  TabItemView.swift
//  Astra
//
//  Created by Andrey Chernyshev on 13.08.2021.
//

import UIKit

final class TabItemView: UIView {
    enum State {
        case selected, deselected
    }
    
    lazy var imageView = makeImageView()
    lazy var circleView = makeCircleView()
    
    var state = State.deselected {
        didSet {
            update()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        makeConstraints()
        update()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Private
private extension TabItemView {
    func update() {
        circleView.isHidden = state == .deselected
        imageView.isHidden = state == .selected
    }
}

// MARK: Make constraints
private extension TabItemView {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: 24.scale),
            imageView.heightAnchor.constraint(equalToConstant: 24.scale),
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: 4.scale)
        ])
        
        NSLayoutConstraint.activate([
            circleView.widthAnchor.constraint(equalToConstant: 9.scale),
            circleView.heightAnchor.constraint(equalToConstant: 9.scale),
            circleView.centerXAnchor.constraint(equalTo: centerXAnchor),
            circleView.topAnchor.constraint(equalTo: topAnchor, constant: 12.scale)
        ])
    }
}

// MARK: Lazy initialization
private extension TabItemView {
    func makeImageView() -> UIImageView {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeCircleView() -> CircleView {
        let view = CircleView()
        view.backgroundColor = UIColor(integralRed: 255, green: 141, blue: 91)
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
}
