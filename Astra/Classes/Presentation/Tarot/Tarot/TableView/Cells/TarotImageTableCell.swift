//
//  TarotImageTableCell.swift
//  Astra
//
//  Created by Andrey Chernyshev on 19.08.2021.
//

import UIKit
import Kingfisher

final class TarotImageTableCell: UITableViewCell {
    lazy var pictureView = makePictureView()
    
    private lazy var reversered = false
    
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
extension TarotImageTableCell {
    func setup(url: URL, isReserved: Bool) {
        pictureView.kf.cancelDownloadTask()
        pictureView.kf.setImage(with: url)
        
        if isReserved, !reversered {
            reversered = true
            pictureView.transform = pictureView.transform.rotated(by: .pi)
        }
    }
}

// MARK: Private
private extension TarotImageTableCell {
    func initialize() {
        backgroundColor = UIColor.clear
        contentView.backgroundColor = UIColor.clear
        
        selectionStyle = .none
    }
}

// MARK: Make constraints
private extension TarotImageTableCell {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            pictureView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            pictureView.widthAnchor.constraint(equalToConstant: 152.scale),
            pictureView.heightAnchor.constraint(equalToConstant: 260.scale),
            pictureView.topAnchor.constraint(equalTo: contentView.topAnchor)
        ])
    }
}

// MARK: Lazy initialization
private extension TarotImageTableCell {
    func makePictureView() -> UIImageView {
        let view = UIImageView()
        view.clipsToBounds = true
        view.contentMode = .scaleAspectFill
        view.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(view)
        return view
    }
}
