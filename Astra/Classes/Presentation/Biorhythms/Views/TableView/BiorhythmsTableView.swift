//
//  BiorhythmsTableView.swift
//  Astra
//
//  Created by Andrey Chernyshev on 14.09.2021.
//

import UIKit

final class BiorhythmsTableView: UITableView {
    weak var mainDelegate: BiorhythmsTableViewDelegate?
    
    private var elements = [BiorhythmsTableElement]()
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Public
extension BiorhythmsTableView {
    func setup(elements: [BiorhythmsTableElement]) {
        self.elements = elements
        
        reloadData()
    }
}

// MARK: UITableViewDataSource
extension BiorhythmsTableView: UITableViewDataSource {
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
        case .chart(let element):
            let cell = dequeueReusableCell(withIdentifier: String(describing: BiorhythmsTableChartCell.self)) as! BiorhythmsTableChartCell
            cell.setup(element: element)
            return cell
        case .whatAreButton:
            let cell = dequeueReusableCell(withIdentifier: String(describing: BiorhythmsTableButtonCell.self)) as! BiorhythmsTableButtonCell
            cell.delegate = mainDelegate
            return cell
        case .component(let component):
            let cell = dequeueReusableCell(withIdentifier: String(describing: BiorhythmsTableComponentCell.self)) as! BiorhythmsTableComponentCell
            cell.setup(element: component)
            return cell
        }
    }
}

// MARK: UITableViewDelegate
extension BiorhythmsTableView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch elements[indexPath.row] {
        case .offset(let offset):
            return offset
        case .chart:
            return 244.scale
        case .whatAreButton:
            return 52.scale
        default:
            return UITableView.automaticDimension
        }
    }
}

// MARK: Private
private extension BiorhythmsTableView {
    func initialize() {
        register(UITableViewCell.self, forCellReuseIdentifier: "OffsetTableCell")
        register(BiorhythmsTableChartCell.self, forCellReuseIdentifier: String(describing: BiorhythmsTableChartCell.self))
        register(BiorhythmsTableButtonCell.self, forCellReuseIdentifier: String(describing: BiorhythmsTableButtonCell.self))
        register(BiorhythmsTableComponentCell.self, forCellReuseIdentifier: String(describing: BiorhythmsTableComponentCell.self))
        
        dataSource = self
        delegate = self
    }
}
