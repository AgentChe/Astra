//
//  PaygateOptionView.swift
//  Astra
//
//  Created by Andrey Chernyshev on 09.09.2021.
//

import UIKit

final class PaygateOptionView: UIView {
    var isSelected = false {
        didSet {
            changeSelection()
        }
    }
    
    var option: PaygateOption? {
        didSet {
            fill()
        }
    }
    
    lazy var titleLabel = makeLabel()
    lazy var subtitleLabel = makeLabel()
    lazy var imageView = makeImageView()
    lazy var saveLabel = makeSaveLabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        makeConstraints()
        fill()
        changeSelection()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Private
private extension PaygateOptionView {
    func fill() {
        guard let option = self.option else {
            return
        }
        
        saveLabel.isHidden = option.save == nil
        
        titleLabel.attributedText = option
            .title
            .attributed(with: TextAttributes()
                            .textColor(isSelected ? UIColor(integralRed: 252, green: 252, blue: 252) : UIColor(integralRed: 31, green: 31, blue: 31))
                            .font(Fonts.Qanelas.regular(size: 20.scale)))
        
        subtitleLabel.attributedText = option
            .subTitle
            .attributed(with: TextAttributes()
                            .textColor(isSelected ? UIColor(integralRed: 252, green: 252, blue: 252) : UIColor(integralRed: 31, green: 31, blue: 31))
                            .font(Fonts.Qanelas.bold(size: 17.scale)))
        
        saveLabel.attributedText = (option.save ?? "")
            .attributed(with: TextAttributes()
                            .textColor(UIColor(integralRed: 31, green: 31, blue: 31))
                            .font(Fonts.Qanelas.bold(size: 13.scale)))
    }
    
    func changeSelection() {
        backgroundColor = isSelected ? UIColor(integralRed: 171, green: 165, blue: 231) : UIColor(integralRed: 252, green: 252, blue: 252)
        imageView.image = UIImage(named: isSelected ? "Paygate.Checked" : "Paygate.Unchecked")
        titleLabel.textColor = isSelected ? UIColor(integralRed: 252, green: 252, blue: 252) : UIColor(integralRed: 31, green: 31, blue: 31)
        subtitleLabel.textColor = isSelected ? UIColor(integralRed: 252, green: 252, blue: 252) : UIColor(integralRed: 31, green: 31, blue: 31)
    }
}

// MARK: Make constraints
private extension PaygateOptionView {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16.scale),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -45.scale),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16.scale)
        ])
        
        NSLayoutConstraint.activate([
            subtitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16.scale),
            subtitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -45.scale),
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 3.scale)
        ])
        
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: 25.scale),
            imageView.heightAnchor.constraint(equalToConstant: 25.scale),
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16.scale)
        ])
        
        NSLayoutConstraint.activate([
            saveLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16.scale),
            saveLabel.centerYAnchor.constraint(equalTo: topAnchor)
        ])
    }
}

// MARK: Lazy initialization
private extension PaygateOptionView {
    func makeLabel() -> UILabel {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeImageView() -> UIImageView {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeSaveLabel() -> PaddingLabel {
        let view = PaddingLabel()
        view.leftInset = 14.scale
        view.rightInset = 14.scale
        view.topInset = 2.scale
        view.bottomInset = 2.scale
        view.backgroundColor = UIColor(integralRed: 252, green: 252, blue: 252)
        view.layer.cornerRadius = 4.scale
        view.layer.masksToBounds = true
        view.isHidden = true
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
}
