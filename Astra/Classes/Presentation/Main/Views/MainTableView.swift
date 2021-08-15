//
//  MainTableView.swift
//  Astra
//
//  Created by Andrey Chernyshev on 14.08.2021.
//

import UIKit

final class MainTableView: UITableView {
    weak var mainDelegate: MainTableViewDelegate?
    
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
        case .offset:
            let cell = dequeueReusableCell(withIdentifier: "OffsetTableCell")!
            cell.backgroundColor = UIColor.clear
            cell.contentView.backgroundColor = UIColor.clear
            cell.selectionStyle = .none
            return cell
        case .profile(let profile):
            let cell = dequeueReusableCell(withIdentifier: String(describing: MainProfileCell.self)) as! MainProfileCell
            cell.setup(element: profile)
            cell.mainDelegate = mainDelegate
            return cell
        case .title(let title):
            let cell = dequeueReusableCell(withIdentifier: String(describing: TitleMainTableCell.self)) as! TitleMainTableCell
            cell.setup(title: title)
            return cell
        }
    }
}

// MARK: UITableViewDelegate
extension MainTableView: UITableViewDelegate {
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
private extension MainTableView {
    func initialize() {
        register(UITableViewCell.self, forCellReuseIdentifier: "OffsetTableCell")
        register(MainProfileCell.self, forCellReuseIdentifier: String(describing: MainProfileCell.self))
        register(TitleMainTableCell.self, forCellReuseIdentifier: String(describing: TitleMainTableCell.self))
        
        dataSource = self
        delegate = self
    }
}
