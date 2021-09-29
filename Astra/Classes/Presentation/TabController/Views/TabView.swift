//
//  TabView.swift
//  Astra
//
//  Created by Andrey Chernyshev on 13.08.2021.
//

import UIKit

final class TabView: UIView {
    enum Tab {
        case horo, meditations, compatibility, natal
    }
    
    lazy var horoItem = makeItem(image: "Tab.Horo")
    lazy var meditationsItem = makeItem(image: "Tab.Meditations")
    lazy var compatibilityItem = makeItem(image: "Tab.Compatibility")
    lazy var natalItem = makeItem(image: "Tab.Natal")
    
    var selectedTab = Tab.horo {
        didSet {
            update()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Private
private extension TabView {
    func update() {
        [
            horoItem,
            meditationsItem,
            compatibilityItem,
            natalItem
        ]
        .forEach {
            $0.state = .deselected
        }
        
        switch selectedTab {
        case .horo:
            horoItem.state = .selected
        case .meditations:
            meditationsItem.state = .selected
        case .compatibility:
            compatibilityItem.state = .selected
        case .natal:
            natalItem.state = .selected
        }
    }
}

// MARK: Make constraints
private extension TabView {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            horoItem.leadingAnchor.constraint(equalTo: leadingAnchor),
            horoItem.bottomAnchor.constraint(equalTo: bottomAnchor),
            horoItem.topAnchor.constraint(equalTo: topAnchor),
            horoItem.widthAnchor.constraint(equalTo: meditationsItem.widthAnchor)
        ])
        
        NSLayoutConstraint.activate([
            meditationsItem.leadingAnchor.constraint(equalTo: horoItem.trailingAnchor),
            meditationsItem.bottomAnchor.constraint(equalTo: bottomAnchor),
            meditationsItem.topAnchor.constraint(equalTo: topAnchor),
            meditationsItem.widthAnchor.constraint(equalTo: compatibilityItem.widthAnchor)
        ])
        
        NSLayoutConstraint.activate([
            compatibilityItem.leadingAnchor.constraint(equalTo: meditationsItem.trailingAnchor),
            compatibilityItem.bottomAnchor.constraint(equalTo: bottomAnchor),
            compatibilityItem.topAnchor.constraint(equalTo: topAnchor),
            compatibilityItem.widthAnchor.constraint(equalTo: natalItem.widthAnchor)
        ])
        
        NSLayoutConstraint.activate([
            natalItem.leadingAnchor.constraint(equalTo: compatibilityItem.trailingAnchor),
            natalItem.bottomAnchor.constraint(equalTo: bottomAnchor),
            natalItem.topAnchor.constraint(equalTo: topAnchor),
            natalItem.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
}

// MARK: Lazy initialization
private extension TabView {
    func makeItem(image: String) -> TabItemView {
        let view = TabItemView()
        view.backgroundColor = UIColor.clear
        view.imageView.image = UIImage(named: image)
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
}
