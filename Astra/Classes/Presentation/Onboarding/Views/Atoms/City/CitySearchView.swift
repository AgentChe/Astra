//
//  CitySearchView.swift
//  Astra
//
//  Created by Andrey Chernyshev on 04.09.2021.
//

import UIKit
import RxSwift
import RxCocoa

final class CitySearchView: UIView {
    lazy var text = BehaviorRelay<String>(value: "")
    
    lazy var imageView = makeImageView()
    lazy var textField = makeTextField()
    lazy var clearButton = makeClearButton()
    
    private lazy var disposeBag = DisposeBag()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        makeConstraits()
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Public
extension CitySearchView {
    func setup(name: String) {
        textField.text = name
    }
}

// MARK: Private
private extension CitySearchView {
    func initialize() {
        text.map { $0.isEmpty }
            .bind(to: clearButton.rx.isHidden)
            .disposed(by: disposeBag)
    }
    
    @objc
    func clear() {
        textField.text = ""
        textChanged()
    }
    
    @objc
    func textChanged() {
        text.accept(textField.text ?? "")
    }
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
        view.addTarget(self, action: #selector(textChanged), for: .editingChanged)
        addSubview(view)
        return view
    }
    
    func makeClearButton() -> TapAreaButton {
        let view = TapAreaButton()
        view.setImage(UIImage(named: "Onboarding.City.SelectClear"), for: .normal)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addTarget(self, action: #selector(clear), for: .touchUpInside)
        addSubview(view)
        return view
    }
}
