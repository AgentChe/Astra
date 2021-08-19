//
//  TarotTagsTableCell.swift
//  Astra
//
//  Created by Andrey Chernyshev on 19.08.2021.
//

import UIKit

final class TarotTagsTableCell: UITableViewCell {
    lazy var tagsView = makeTagsView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        makeConstraints()
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Public
extension TarotTagsTableCell {
    func setup(tags: [String]) {
        tagsView.removeAllTags()
        tagsView.addTags(tags)
    }
}

// MARK: Private
private extension TarotTagsTableCell {
    func initialize() {
        backgroundColor = UIColor.clear
        contentView.backgroundColor = UIColor.clear
        
        selectionStyle = .none
    }
}

// MARK: Make constraints
private extension TarotTagsTableCell {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            tagsView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32.scale),
            tagsView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -32.scale),
            tagsView.topAnchor.constraint(equalTo: contentView.topAnchor),
            tagsView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}

// MARK: Lazy initialization
private extension TarotTagsTableCell {
    func makeTagsView() -> TagsView {
        let view = TagsView()
        view.alignment = .center
        view.radius = 13.scale
        view.borderlineColor = UIColor(integralRed: 31, green: 31, blue: 31)
        view.borderlineWidth = 1.scale
        view.tagBackgroundColor = .clear
        view.paddingX = 10.scale
        view.paddingY = 6.scale
        view.marginX = 6.scale
        view.marginY = 6.scale
        view.textColor = UIColor(integralRed: 31, green: 31, blue: 31)
        view.textFont = Fonts.Qanelas.regular(size: 14.scale)
        view.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(view)
        return view
    }
}
