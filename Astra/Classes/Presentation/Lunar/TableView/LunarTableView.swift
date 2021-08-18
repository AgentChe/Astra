//
//  LunarTableView.swift
//  Astra
//
//  Created by Andrey Chernyshev on 18.08.2021.
//


import UIKit

final class LunarTableView: UITableView {
    private var elements = [LunarTableElement]()
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Public
extension LunarTableView {
    func setup(elements: [LunarTableElement]) {
        self.elements = elements
        
        reloadData()
    }
}

// MARK: UITableViewDataSource
extension LunarTableView: UITableViewDataSource {
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
        case .lunarCalendar(let days):
            let cell = dequeueReusableCell(withIdentifier: String(describing: LunarCalendarTableCell.self)) as! LunarCalendarTableCell
            cell.setup(element: days)
            return cell
        case .lunarArticle(let article):
            let cell = dequeueReusableCell(withIdentifier: String(describing: LunarArticleTableCell.self)) as! LunarArticleTableCell
            cell.setup(element: article)
            return cell
        case .separator:
            return dequeueReusableCell(withIdentifier: String(describing: SeparatorLunarTableCell.self), for: indexPath)
        case .title(let title):
            let cell = dequeueReusableCell(withIdentifier: String(describing: TitleLunarTableCell.self)) as! TitleLunarTableCell
            cell.setup(title: title)
            return cell
        case .favorable(let favorable):
            let cell = dequeueReusableCell(withIdentifier: String(describing: FavorableLunarTableCell.self)) as! FavorableLunarTableCell
            cell.setup(element: favorable)
            return cell
        case .numbers(let numbers):
            let cell = dequeueReusableCell(withIdentifier: String(describing: NumbersLunarTableCell.self)) as! NumbersLunarTableCell
            cell.setup(element: numbers)
            return cell
        }
    }
}

// MARK: UITableViewDelegate
extension LunarTableView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch elements[indexPath.row] {
        case .offset(let offset):
            return offset
        case .lunarCalendar:
            return 100.scale
        case .separator:
            return 1.scale
        case .numbers:
            return 104.scale
        default:
            return UITableView.automaticDimension
        }
    }
}

// MARK: Private
private extension LunarTableView {
    func initialize() {
        register(UITableViewCell.self, forCellReuseIdentifier: "OffsetTableCell")
        register(LunarCalendarTableCell.self, forCellReuseIdentifier: String(describing: LunarCalendarTableCell.self))
        register(LunarArticleTableCell.self, forCellReuseIdentifier: String(describing: LunarArticleTableCell.self))
        register(SeparatorLunarTableCell.self, forCellReuseIdentifier: String(describing: SeparatorLunarTableCell.self))
        register(TitleLunarTableCell.self, forCellReuseIdentifier: String(describing: TitleLunarTableCell.self))
        register(FavorableLunarTableCell.self, forCellReuseIdentifier: String(describing: FavorableLunarTableCell.self))
        register(NumbersLunarTableCell.self, forCellReuseIdentifier: String(describing: NumbersLunarTableCell.self))
        
        dataSource = self
        delegate = self
    }
}
