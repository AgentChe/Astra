//
//  HoroTableView.swift
//  Astra
//
//  Created by Andrey Chernyshev on 17.08.2021.
//

import UIKit

final class HoroTableView: UITableView {
    private var elements = [HoroTableElement]()
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Public
extension HoroTableView {
    func setup(elements: [HoroTableElement]) {
        self.elements = elements
        
        reloadData()
    }
}

// MARK: UITableViewDataSource
extension HoroTableView: UITableViewDataSource {
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
        case .filter(let filters):
            let cell = dequeueReusableCell(withIdentifier: String(describing: HoroFilterMainTableCell.self)) as! HoroFilterMainTableCell
            cell.collectionView.horoFilterDelegate = self
            cell.setup(element: filters)
            return cell
        case .image(let path):
            let cell = dequeueReusableCell(withIdentifier: String(describing: HoroImageMainCell.self)) as! HoroImageMainCell
            cell.setup(path: path)
            return cell
        case .article(let element):
            if element.isOpened {
                let cell = dequeueReusableCell(withIdentifier: String(describing: HoroArticleOpenedTableCell.self)) as! HoroArticleOpenedTableCell
                cell.setup(element: element)
                return cell
            } else {
                let cell = dequeueReusableCell(withIdentifier: String(describing: HoroArticleClosedTableCell.self)) as! HoroArticleClosedTableCell
                cell.setup(element: element)
                return cell
            }
        }
    }
}

// MARK: HoroFilterCellDelegate
extension HoroTableView: HoroFilterCellDelegate {
    func horoFilterCellDidUpdated(selectedPeriod: String) {
        var indexPaths = [IndexPath]()
        
        for (index, element) in elements.enumerated() {
            guard case let .article(content) = element else {
                continue
            }
            
            content.selectedPeriod = selectedPeriod
            
            let indexPath = IndexPath(row: index, section: 0)
            indexPaths.append(indexPath)
        }
        
        reloadRows(at: indexPaths, with: .automatic)
    }
}

// MARK: UITableViewDelegate
extension HoroTableView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch elements[indexPath.row] {
        case .offset(let offset):
            return offset
        case .filter:
            return 34.scale
        case .image:
            return 292.scale
        default:
            return UITableView.automaticDimension
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch elements[indexPath.row] {
        case .article(let element):
            element.isOpened.toggle()
            
            reloadRows(at: [indexPath], with: .automatic)
        default:
            return
        }
    }
}

// MARK: Private
private extension HoroTableView {
    func initialize() {
        register(UITableViewCell.self, forCellReuseIdentifier: "OffsetTableCell")
        register(HoroFilterMainTableCell.self, forCellReuseIdentifier: String(describing: HoroFilterMainTableCell.self))
        register(HoroImageMainCell.self, forCellReuseIdentifier: String(describing: HoroImageMainCell.self))
        register(HoroArticleOpenedTableCell.self, forCellReuseIdentifier: String(describing: HoroArticleOpenedTableCell.self))
        register(HoroArticleClosedTableCell.self, forCellReuseIdentifier: String(describing: HoroArticleClosedTableCell.self))
        
        dataSource = self
        delegate = self
    }
}
