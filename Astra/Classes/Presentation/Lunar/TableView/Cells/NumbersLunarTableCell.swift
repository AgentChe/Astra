//
//  NumbersLunarTableCell.swift
//  Astra
//
//  Created by Andrey Chernyshev on 19.08.2021.
//

import UIKit

final class NumbersLunarTableCell: UITableViewCell {
    lazy var container = makeContainer()
    lazy var label1 = makeLabel()
    lazy var separator1 = makeSeparator()
    lazy var label2 = makeLabel()
    lazy var separator2 = makeSeparator()
    lazy var label3 = makeLabel()
    
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
extension NumbersLunarTableCell {
    func setup(element: [Int]) {
        let attrs = TextAttributes()
            .textColor(UIColor.white)
            .textAlignment(.center)
            .font(Fonts.Qanelas.regular(size: 48.scale))
            .lineHeight(57.12.scale)
        
        let labels = [label1, label2, label3]
        
        element.enumerated().forEach { index, number in
            guard labels.indices.contains(index) else {
                return
            }
            
            labels[index].attributedText = String(number).attributed(with: attrs)
        }
    }
}

// MARK: Private
private extension NumbersLunarTableCell {
    func initialize() {
        backgroundColor = UIColor.clear
        contentView.backgroundColor = UIColor.clear
        
        selectionStyle = .none
    }
}

// MARK: Make constraints
private extension NumbersLunarTableCell {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            container.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16.scale),
            container.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16.scale),
            container.topAnchor.constraint(equalTo: contentView.topAnchor),
            container.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            label1.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            label1.centerYAnchor.constraint(equalTo: container.centerYAnchor),
            label1.widthAnchor.constraint(equalTo: label2.widthAnchor)
        ])
        
        NSLayoutConstraint.activate([
            label2.leadingAnchor.constraint(equalTo: label1.trailingAnchor),
            label2.centerYAnchor.constraint(equalTo: container.centerYAnchor),
            label2.widthAnchor.constraint(equalTo: label3.widthAnchor)
        ])
        
        NSLayoutConstraint.activate([
            label3.leadingAnchor.constraint(equalTo: label2.trailingAnchor),
            label3.centerYAnchor.constraint(equalTo: container.centerYAnchor),
            label3.trailingAnchor.constraint(equalTo: container.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            separator1.widthAnchor.constraint(equalToConstant: 1.scale),
            separator1.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 112.scale),
            separator1.heightAnchor.constraint(equalToConstant: 35.scale),
            separator1.centerYAnchor.constraint(equalTo: container.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            separator2.widthAnchor.constraint(equalToConstant: 1.scale),
            separator2.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 223.scale),
            separator2.heightAnchor.constraint(equalToConstant: 35.scale),
            separator2.centerYAnchor.constraint(equalTo: container.centerYAnchor)
        ])
    }
}

// MARK: Lazy initialization
private extension NumbersLunarTableCell {
    func makeContainer() -> UIView {
        let view = UIView()
        view.backgroundColor = UIColor(integralRed: 31, green: 31, blue: 31, alpha: 0.4)
        view.layer.cornerRadius = 4.scale
        view.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(view)
        return view
    }
    
    func makeLabel() -> UILabel {
        let view = UILabel()
        view.numberOfLines = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(view)
        return view
    }
    
    func makeSeparator() -> UIView {
        let view = UIView()
        view.backgroundColor = UIColor(integralRed: 233, green: 231, blue: 228)
        view.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(view)
        return view
    }
}
