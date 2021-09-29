//
//  NatalDetailsTableView.swift
//  Astra
//
//  Created by Andrey Chernyshev on 29.09.2021.
//

import UIKit

final class NatalDetailsTableView: UITableView {
    private var elements = [NatalDetailsTableElement]()
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Public
extension NatalDetailsTableView {
    func setup(elements: [NatalDetailsTableElement]) {
        self.elements = elements
        
        reloadData()
    }
}

// MARK: UITableViewDataSource
extension NatalDetailsTableView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        elements.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch elements[indexPath.row] {
        case .offset:
            let cell = dequeueReusableCell(withIdentifier: "OffsetTableCell")!
            cell.backgroundColor = UIColor.clear
            cell.contentView.backgroundColor = UIColor.clear
            cell.selectionStyle = .none
            return cell
        case .title(let article):
            let cell = dequeueReusableCell(withIdentifier: String(describing: NatalDetailsTableTitleCell.self)) as! NatalDetailsTableTitleCell
            cell.setup(article: article)
            return cell
        case .text(let text):
            let cell = dequeueReusableCell(withIdentifier: String(describing: NatalDetailsTableTextCell.self)) as! NatalDetailsTableTextCell
            cell.setup(text: text)
            return cell
        }
    }
}

// MARK: UITableViewDelegate
extension NatalDetailsTableView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch elements[indexPath.row] {
        case .offset(let offset):
            return offset
        default:
            return UITableView.automaticDimension
        }
    }
}

// MARK: Private
private extension NatalDetailsTableView {
    func initialize() {
        register(UITableViewCell.self, forCellReuseIdentifier: "OffsetTableCell")
        register(NatalDetailsTableTitleCell.self, forCellReuseIdentifier: String(describing: NatalDetailsTableTitleCell.self))
        register(NatalDetailsTableTextCell.self, forCellReuseIdentifier: String(describing: NatalDetailsTableTextCell.self))
        
        dataSource = self
        delegate = self
    }
}
