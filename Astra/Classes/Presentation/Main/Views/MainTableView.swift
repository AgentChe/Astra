//
//  MainTableView.swift
//  Astra
//
//  Created by Andrey Chernyshev on 14.08.2021.
//

import UIKit

final class MainTableView: UITableView {
    private var elements = [MainTableElement]()
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Public
extension MainTableView {
    func setup(elements: [MainTableElement]) {
        self.elements = elements
        
        reloadData()
    }
}

// MARK: UITableViewDataSource
extension MainTableView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        elements.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch elements[indexPath.row] {
        case .offset(let offset):
            return UITableViewCell()
        }
    }
}

// MARK: UITableViewDelegate
extension MainTableView: UITableViewDelegate {
    
}

// MARK: Private
private extension MainTableView {
    func initialize() {
        dataSource = self
        delegate = self
    }
}
