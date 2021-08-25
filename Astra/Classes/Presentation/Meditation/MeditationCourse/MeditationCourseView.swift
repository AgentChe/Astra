//
//  MeditationCourseView.swift
//  Astra
//
//  Created by Andrey Chernyshev on 25.08.2021.
//

import UIKit

final class MeditationCourseView: UIView {
    lazy var tableView = makeTableView()
    
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
private extension MeditationCourseView {
    func initialize() {
        backgroundColor = UIColor(integralRed: 252, green: 252, blue: 252)
    }
}

// MARK: Make constraints
private extension MeditationCourseView {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

// MARK: Lazy initialization
private extension MeditationCourseView {
    func makeTableView() -> MeditationCourseTableView {
        let view = MeditationCourseTableView()
        view.backgroundColor = UIColor.clear
        view.separatorStyle = .none
        view.showsVerticalScrollIndicator = false
        view.contentInsetAdjustmentBehavior = .never
        view.contentInset = UIEdgeInsets(top: 0.scale, left: 0, bottom: 16.scale, right: 0)
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
}
