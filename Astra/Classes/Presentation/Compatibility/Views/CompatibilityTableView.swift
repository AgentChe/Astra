//
//  CompatibilityTableView.swift
//  Astra
//
//  Created by Andrey Chernyshev on 23.08.2021.
//

import UIKit

final class CompatibilityTableView: UITableView {
    private var elements = [CompatibilityTableElement]()
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Public
extension CompatibilityTableView {
    func setup(elements: [CompatibilityTableElement]) {
        self.elements = elements
        
        reloadData()
    }
}

// MARK: UITableViewDataSource
extension CompatibilityTableView: UITableViewDataSource {
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
        case .images(let code1, let code2):
            let cell = dequeueReusableCell(withIdentifier: String(describing: CompatibilitySignsImagesTableCell.self)) as! CompatibilitySignsImagesTableCell
            cell.setup(code1: code1, code2: code2)
            return cell
        case .names(let code1, let code2):
            let cell = dequeueReusableCell(withIdentifier: String(describing: CompatibilitySignsNamesTableCell.self)) as! CompatibilitySignsNamesTableCell
            cell.setup(code1: code1, code2: code2)
            return cell
        case .values(let values):
            let cell = dequeueReusableCell(withIdentifier: String(describing: CompatibilityValuesTableCell.self)) as! CompatibilityValuesTableCell
            cell.setup(values: values)
            return cell
        case .text(let text):
            let cell = dequeueReusableCell(withIdentifier: String(describing: CompatibilityTextTableCelll.self)) as! CompatibilityTextTableCelll
            cell.setup(text: text)
            return cell
        }
    }
}

// MARK: UITableViewDelegate
extension CompatibilityTableView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch elements[indexPath.row] {
        case .offset(let offset):
            return offset
        case .images:
            return 160.scale
        case .values:
            return 276.scale
        default:
            return UITableView.automaticDimension
        }
    }
}

// MARK: Private
private extension CompatibilityTableView {
    func initialize() {
        register(UITableViewCell.self, forCellReuseIdentifier: "OffsetTableCell")
        register(CompatibilitySignsImagesTableCell.self, forCellReuseIdentifier: String(describing: CompatibilitySignsImagesTableCell.self))
        register(CompatibilitySignsNamesTableCell.self, forCellReuseIdentifier: String(describing: CompatibilitySignsNamesTableCell.self))
        register(CompatibilityValuesTableCell.self, forCellReuseIdentifier: String(describing: CompatibilityValuesTableCell.self))
        register(CompatibilityTextTableCelll.self, forCellReuseIdentifier: String(describing: CompatibilityTextTableCelll.self))
        
        dataSource = self
        delegate = self
    }
}
