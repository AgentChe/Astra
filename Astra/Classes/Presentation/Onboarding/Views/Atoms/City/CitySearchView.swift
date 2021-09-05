//
//  CitySearchView.swift
//  Astra
//
//  Created by Andrey Chernyshev on 04.09.2021.
//

import UIKit
import RxSwift

final class CitySearchView: UIView {
    lazy var imageView = makeImageView()
    lazy var textField = makeTextField()
    lazy var clearButton = makeClearButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        makeConstraits()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Private
private extension CitySearchView {
    
}

// MARK: Make constraints
private extension CitySearchView {
    func makeConstraits() {
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: 24.scale),
            imageView.heightAnchor.constraint(equalToConstant: 24.scale),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8.scale),
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            textField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40.scale),
            textField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -36.scale),
            textField.topAnchor.constraint(equalTo: topAnchor),
            textField.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            clearButton.widthAnchor.constraint(equalToConstant: 18.scale),
            clearButton.heightAnchor.constraint(equalToConstant: 18.scale),
            clearButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            clearButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8.scale)
        ])
    }
}

// MARK: Lazy initialization
private extension CitySearchView {
    func makeImageView() -> UIImageView {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.image = UIImage(named: "Onboarding.City.SelectIcon")
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeTextField() -> UITextField {
        let view = UITextField()
        view.backgroundColor = UIColor.clear
        view.autocorrectionType = .no
        view.textColor = UIColor(integralRed: 63, green: 63, blue: 63)
        view.font = Fonts.Qanelas.regular(size: 24.scale)
        view.placeholder = "Onboarding.City.Placeholder".localized
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeClearButton() -> TapAreaButton {
        let view = TapAreaButton()
        view.setImage(UIImage(named: "Onboarding.City.SelectClear"), for: .normal)
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
}
