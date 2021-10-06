//
//  MainView.swift
//  Astra
//
//  Created by Andrey Chernyshev on 13.08.2021.
//

import UIKit

final class MainView: UIView {
    lazy var tableView = makeTableView()
    lazy var topGradientView = makeTopGradientView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        makeConstraints()
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Private
private extension MainView {
    func initialize() {
        backgroundColor = UIColor(integralRed: 252, green: 252, blue: 252)
    }
}

// MARK: Make constraints
private extension MainView {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            topGradientView.leadingAnchor.constraint(equalTo: leadingAnchor),
            topGradientView.trailingAnchor.constraint(equalTo: trailingAnchor),
            topGradientView.topAnchor.constraint(equalTo: topAnchor),
            topGradientView.heightAnchor.constraint(equalToConstant: 88.scale)
        ])
    }
}

// MARK: Lazy initialization
private extension MainView {
    func makeTableView() -> MainTableView {
        let view = MainTableView()
        view.backgroundColor = UIColor.clear
        view.separatorStyle = .none
        view.showsVerticalScrollIndicator = false
        view.contentInset = UIEdgeInsets(top: 0.scale, left: 0, bottom: 16.scale, right: 0)
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeTopGradientView() -> GradientView {
        let view = GradientView()
        view.gradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
        view.gradientLayer.endPoint = CGPoint(x: 0.5, y: 1)
        view.gradientLayer.colors = [
            UIColor(integralRed: 252, green: 252, blue: 252, alpha: 1).cgColor,
            UIColor(integralRed: 252, green: 252, blue: 252, alpha: 0.1).cgColor
        ]
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
}
