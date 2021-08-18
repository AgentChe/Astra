//
//  SettingsTableView.swift
//  Astra
//
//  Created by Andrey Chernyshev on 18.08.2021.
//

import UIKit

final class SettingsTableView: UITableView {
    private var elements = [SettingsTableElement]()
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Public
extension SettingsTableView {
    func setup(elements: [SettingsTableElement]) {
        self.elements = elements
        
        reloadData()
    }
}

// MARK: UITableViewDataSource
extension SettingsTableView: UITableViewDataSource {
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
        case .link(let title, _):
            let cell = dequeueReusableCell(withIdentifier: String(describing: SettingsLinkTableCell.self)) as! SettingsLinkTableCell
            cell.setup(title: title)
            return cell
        case .rateUs(let title):
            let cell = dequeueReusableCell(withIdentifier: String(describing: SettingsLinkTableCell.self)) as! SettingsLinkTableCell
            cell.setup(title: title)
            return cell
        }
    }
}

// MARK: UITableViewDelegate
extension SettingsTableView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch elements[indexPath.row] {
        case .offset(let offset):
            return offset
        default:
            return UITableView.automaticDimension
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch elements[indexPath.row] {
        case .link(_, let path):
            guard let url = URL(string: path) else {
                return
            }
            
            UIApplication.shared.open(url, options: [:])
        case .rateUs:
            RateUs.requestReview()
        default:
            return
        }
    }
}

// MARK: Private
private extension SettingsTableView {
    func initialize() {
        register(UITableViewCell.self, forCellReuseIdentifier: "OffsetTableCell")
        register(SettingsLinkTableCell.self, forCellReuseIdentifier: String(describing: SettingsLinkTableCell.self))
        
        dataSource = self
        delegate = self
    }
}
