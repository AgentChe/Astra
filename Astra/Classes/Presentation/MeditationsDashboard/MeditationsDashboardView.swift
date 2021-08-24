//
//  MeditationsDashboardView.swift
//  Astra
//
//  Created by Andrey Chernyshev on 24.08.2021.
//

import UIKit

final class MeditationsDashboardView: UIView {
    lazy var filtersView = makeFiltersView()
    
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
private extension MeditationsDashboardView {
    func initialize() {
        backgroundColor = UIColor(integralRed: 252, green: 252, blue: 252)
    }
}

// MARK: Make constraints
private extension MeditationsDashboardView {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            filtersView.leadingAnchor.constraint(equalTo: leadingAnchor),
            filtersView.trailingAnchor.constraint(equalTo: trailingAnchor),
            filtersView.heightAnchor.constraint(equalToConstant: 34.scale),
            filtersView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 24.scale)
        ])
    }
}

// MARK: Lazy initialization
private extension MeditationsDashboardView {
    func makeFiltersView() -> MeditationsFilterCollectionView {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let view = MeditationsFilterCollectionView(frame: .zero, collectionViewLayout: layout)
        view.contentInset = UIEdgeInsets(top: 0, left: 24.scale, bottom: 0, right: 24.scale)
        view.backgroundColor = UIColor.clear
        view.showsHorizontalScrollIndicator = false
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
}
