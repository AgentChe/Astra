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
        case .horoFilter(let filters):
            let cell = dequeueReusableCell(withIdentifier: String(describing: HoroFilterMainTableCell.self)) as! HoroFilterMainTableCell
            cell.collectionView.horoFilterDelegate = self
            cell.setup(element: filters)
            return cell
        case .horoImage(let path):
            let cell = dequeueReusableCell(withIdentifier: String(describing: HoroImageMainCell.self)) as! HoroImageMainCell
            cell.setup(path: path)
            return cell
        case .horoContent(let content):
            let cell = dequeueReusableCell(withIdentifier: String(describing: HoroContentMainTableCell.self)) as! HoroContentMainTableCell
            cell.setup(element: content)
            return cell
        case .horoButton:
            return dequeueReusableCell(withIdentifier: String(describing: HoroButtonMainTableCell.self), for: indexPath)
        case .chart(let element):
            if element.isOpened {
                let cell = dequeueReusableCell(withIdentifier: String(describing: ChartOpenedMainTableCell.self)) as! ChartOpenedMainTableCell
                cell.setup(element: element)
                return cell
            } else {
                let cell = dequeueReusableCell(withIdentifier: String(describing: ChartClosedMainTableCell.self)) as! ChartClosedMainTableCell
                cell.setup(element: element)
                return cell
            }
        case .separator:
            return dequeueReusableCell(withIdentifier: String(describing: SeparatorMainTableCell.self), for: indexPath)
        case .lunarArticle(let article):
            let cell = dequeueReusableCell(withIdentifier: String(describing: LunarArticleMainTableCell.self)) as! LunarArticleMainTableCell
            cell.setup(element: article)
            return cell
        case .lunarButton:
            return dequeueReusableCell(withIdentifier: String(describing: LunarButtonMainTableCell.self), for: indexPath)
        }
    }
}

// MARK: HoroFilterCellDelegate
extension MainTableView: HoroFilterCellDelegate {
    func horoFilterCellDidUpdated(selectedPeriod: String) {
        let firstIndex = elements.firstIndex(where: { element -> Bool in
            guard case .horoContent = element else {
                return false
            }
            
            return true
        })
        
        guard let index = firstIndex else {
            return
        }
        
        guard case let .horoContent(content) = elements[index] else {
            return
        }
        
        content.selectedPeriod = selectedPeriod
        
        let indexPath = IndexPath(row: index, section: 0)
        reloadRows(at: [indexPath], with: .automatic)
    }
}

// MARK: UITableViewDelegate
extension MainTableView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch elements[indexPath.row] {
        case .offset(let offset):
            return offset
        case .horoFilter:
            return 34.scale
        case .horoImage:
            return 292.scale
        case .horoButton, .lunarButton:
            return 77.scale
        case .separator:
            return 1.scale
        default:
            return UITableView.automaticDimension
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch elements[indexPath.row] {
        case .chart(let element):
            element.isOpened.toggle()
            
            reloadRows(at: [indexPath], with: .automatic)
        default:
            return
        }
    }
}

// MARK: Private
private extension MainTableView {
    func initialize() {
        register(UITableViewCell.self, forCellReuseIdentifier: "OffsetTableCell")
        register(MainProfileCell.self, forCellReuseIdentifier: String(describing: MainProfileCell.self))
        register(TitleMainTableCell.self, forCellReuseIdentifier: String(describing: TitleMainTableCell.self))
        register(HoroFilterMainTableCell.self, forCellReuseIdentifier: String(describing: HoroFilterMainTableCell.self))
        register(HoroImageMainCell.self, forCellReuseIdentifier: String(describing: HoroImageMainCell.self))
        register(HoroContentMainTableCell.self, forCellReuseIdentifier: String(describing: HoroContentMainTableCell.self))
        register(HoroButtonMainTableCell.self, forCellReuseIdentifier: String(describing: HoroButtonMainTableCell.self))
        register(ChartOpenedMainTableCell.self, forCellReuseIdentifier: String(describing: ChartOpenedMainTableCell.self))
        register(ChartClosedMainTableCell.self, forCellReuseIdentifier: String(describing: ChartClosedMainTableCell.self))
        register(SeparatorMainTableCell.self, forCellReuseIdentifier: String(describing: SeparatorMainTableCell.self))
        register(LunarArticleMainTableCell.self, forCellReuseIdentifier: String(describing: LunarArticleMainTableCell.self))
        register(LunarButtonMainTableCell.self, forCellReuseIdentifier: String(describing: LunarButtonMainTableCell.self))
        
        dataSource = self
        delegate = self
    }
}
