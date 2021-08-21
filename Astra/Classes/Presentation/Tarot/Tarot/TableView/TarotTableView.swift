//
//  TarotTableView.swift
//  Astra
//
//  Created by Andrey Chernyshev on 19.08.2021.
//

import UIKit

final class TarotTableView: UITableView {
    weak var vc: TarotViewController?
    
    private var elements = [TarotTableElement]()
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Public
extension TarotTableView {
    func setup(elements: [TarotTableElement]) {
        self.elements = elements
        
        reloadData()
    }
}

// MARK: UITableViewDataSource
extension TarotTableView: UITableViewDataSource {
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
        case .image(let url, let isReserved):
            let cell = dequeueReusableCell(withIdentifier: String(describing: TarotImageTableCell.self)) as! TarotImageTableCell
            cell.setup(url: url, isReserved: isReserved)
            return cell
        case .reversed:
            return dequeueReusableCell(withIdentifier: String(describing: TarotReservedTableCell.self)) as! TarotReservedTableCell
        case .name(let name):
            let cell = dequeueReusableCell(withIdentifier: String(describing: TarotNameTableCell.self)) as! TarotNameTableCell
            cell.setup(name: name)
            return cell
        case .tags(let tags):
            let cell = dequeueReusableCell(withIdentifier: String(describing: TarotTagsTableCell.self)) as! TarotTagsTableCell
            cell.setup(tags: tags)
            return cell
        case .text(let text):
            let cell = dequeueReusableCell(withIdentifier: String(describing: TarotTextTableCell.self)) as! TarotTextTableCell
            cell.setup(text: text)
            return cell
        }
    }
}

// MARK: UITableViewDelegate
extension TarotTableView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch elements[indexPath.row] {
        case .offset(let offset):
            return offset
        case .image:
            return 260.scale
        case .reversed:
            return 24.scale
        default:
            return UITableView.automaticDimension
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let vc = vc, let cell = cellForRow(at: indexPath) as? TarotImageTableCell else {
            return
        }
        
        guard case let .image(url, isReversed) = elements[indexPath.row] else {
            return
        }
        
        let path = url.absoluteString
        
        let pictureInCellFrame = cell.convert(cell.pictureView.frame, to: cell)
        let pictureInVCFrame = convert(pictureInCellFrame, to: vc.mainView)
        
        vc.taroTableViewDidSelect(imagePath: path, isReversed: isReversed, in: pictureInVCFrame)
    }
}

// MARK: Private
private extension TarotTableView {
    func initialize() {
        register(UITableViewCell.self, forCellReuseIdentifier: "OffsetTableCell")
        register(TarotImageTableCell.self, forCellReuseIdentifier: String(describing: TarotImageTableCell.self))
        register(TarotReservedTableCell.self, forCellReuseIdentifier: String(describing: TarotReservedTableCell.self))
        register(TarotNameTableCell.self, forCellReuseIdentifier: String(describing: TarotNameTableCell.self))
        register(TarotTagsTableCell.self, forCellReuseIdentifier: String(describing: TarotTagsTableCell.self))
        register(TarotTextTableCell.self, forCellReuseIdentifier: String(describing: TarotTextTableCell.self))
        
        dataSource = self
        delegate = self
    }
}
