//
//  TabMainView.swift
//  Astra
//
//  Created by Andrey Chernyshev on 13.08.2021.
//

import UIKit

final class TabMainView: UIView {
    lazy var container = makeContainer()
    lazy var tabView = makeTabView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Make constraints
private extension TabMainView {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            container.leadingAnchor.constraint(equalTo: leadingAnchor),
            container.trailingAnchor.constraint(equalTo: trailingAnchor),
            container.topAnchor.constraint(equalTo: topAnchor),
            container.bottomAnchor.constraint(equalTo: tabView.topAnchor)
        ])
        
        NSLayoutConstraint.activate([
            tabView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tabView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tabView.bottomAnchor.constraint(equalTo: bottomAnchor),
            tabView.heightAnchor.constraint(equalToConstant: ScreenSize.isIphoneXFamily ? 83.scale : 60.scale)
        ])
    }
}

// MARK: Lazy initialization
private extension TabMainView {
    func makeContainer() -> UIView {
        let view = UIView()
        view.backgroundColor = UIColor(integralRed: 252, green: 252, blue: 252)
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeTabView() -> TabView {
        let view = TabView()
        view.backgroundColor = UIColor(integralRed: 252, green: 252, blue: 252)
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
}
