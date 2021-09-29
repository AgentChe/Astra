//
//  NatalTableImageView.swift
//  Astra
//
//  Created by Andrey Chernyshev on 29.09.2021.
//

import UIKit
import Kingfisher

final class NatalTableImageView: UITableViewCell {
    lazy var photoView = makeImageView()
    
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
extension NatalTableImageView {
    func setup(path: String) {
        if let url = URL(string: path) {
            photoView.kf.setImage(with: url)
        }
    }
}

// MARK: Private
private extension NatalTableImageView {
    func initialize() {
        backgroundColor = UIColor.clear
        contentView.backgroundColor = UIColor.clear
        
        selectionStyle = .none
    }
}

// MARK: Make constraints
private extension NatalTableImageView {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            photoView.widthAnchor.constraint(equalToConstant: 343.scale),
            photoView.heightAnchor.constraint(equalToConstant: 335.scale),
            photoView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            photoView.topAnchor.constraint(equalTo: contentView.topAnchor)
        ])
    }
}

// MARK: Lazy initialization
private extension NatalTableImageView {
    func makeImageView() -> UIImageView {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(view)
        return view
    }
}
