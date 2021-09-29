//
//  NatalTableView.swift
//  Astra
//
//  Created by Andrey Chernyshev on 29.09.2021.
//

import UIKit

final class NatalTableView: UITableView {
    weak var mainDelegate: NatalTableViewDelegate?
    
    private var elements = [NatalTableElement]()
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Public
extension NatalTableView {
    func setup(elements: [NatalTableElement]) {
        self.elements = elements
        
        reloadData()
    }
}

// MARK: UITableViewDataSource
extension NatalTableView: UITableViewDataSource {
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
        case .image(let path):
            let cell = dequeueReusableCell(withIdentifier: String(describing: NatalTableImageView.self)) as! NatalTableImageView
            cell.setup(path: path)
            return cell
        case .whatAreButton:
            let cell = dequeueReusableCell(withIdentifier: String(describing: NatalTableButtonCell.self)) as! NatalTableButtonCell
            cell.delegate = mainDelegate
            return cell
        case .article(let article):
            let cell = dequeueReusableCell(withIdentifier: String(describing: NatalTableArticleCell.self)) as! NatalTableArticleCell
            cell.delegate = mainDelegate
            cell.setup(article: article)
            return cell
        }
    }
}

// MARK: UITableViewDelegate
extension NatalTableView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch elements[indexPath.row] {
        case .offset(let offset):
            return offset
        case .image:
            return 335.scale
        case .whatAreButton:
            return 52.scale
        default:
            return UITableView.automaticDimension
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard case let .article(article) = elements[indexPath.row] else {
            return
        }
        
        mainDelegate?.natalTableDidTapped(article: article)
    }
}

// MARK: Private
private extension NatalTableView {
    func initialize() {
        register(UITableViewCell.self, forCellReuseIdentifier: "OffsetTableCell")
        register(NatalTableImageView.self, forCellReuseIdentifier: String(describing: NatalTableImageView.self))
        register(NatalTableButtonCell.self, forCellReuseIdentifier: String(describing: NatalTableButtonCell.self))
        register(NatalTableArticleCell.self, forCellReuseIdentifier: String(describing: NatalTableArticleCell.self))
        
        dataSource = self
        delegate = self
    }
}
