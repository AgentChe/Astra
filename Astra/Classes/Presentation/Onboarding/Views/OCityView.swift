//
//  OCityView.swift
//  Astra
//
//  Created by Andrey Chernyshev on 04.09.2021.
//

import UIKit
import RxSwift

final class OCityView: OSlideView {
    lazy var titleLabel = makeTitleLabel()
    lazy var searchView = makeSearchView()
    lazy var imageView = makeImageView()
    lazy var tableView = makeTableView()
    lazy var button = makeButton()
    
    private lazy var disposeBag = DisposeBag()
    
    private lazy var userManager = UserManagerCore()
    
    private var selectedCity: City?
    
    override init(step: OnboardingView.Step) {
        super.init(step: step)
        
        makeConstraits()
        initiallize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Private
private extension OCityView {
    func initiallize() {
        searchView.text
            .filter { $0.count >= 3 }
            .distinctUntilChanged()
            .flatMapLatest { [weak self] text -> Single<[City]> in
                guard let self = self else {
                    return .never()
                }
                
                return self.userManager
                    .searchCities(with: text)
                    .catchAndReturn([])
            }
            .asDriver(onErrorJustReturn: [])
            .drive(onNext: { [weak self] cities in
                self?.tableView.setup(cities: cities)
            })
            .disposed(by: disposeBag)
        
        searchView.text
            .map { $0.count >= 3 ? OCityButton.Style.next : OCityButton.Style.skip }
            .startWith(.skip)
            .distinctUntilChanged()
            .subscribe(onNext: { [weak self] style in
                self?.button.style = style
            })
            .disposed(by: disposeBag)
        
        searchView.text
            .map { $0.count >= 3 }
            .startWith(false)
            .distinctUntilChanged()
            .subscribe(onNext: { [weak self] hasName in
                self?.imageView.isHidden = hasName
                self?.tableView.isHidden = !hasName
            })
            .disposed(by: disposeBag)
        
        searchView.text
            .subscribe(onNext: { [weak self] _ in
                self?.selectedCity = nil
            })
            .disposed(by: disposeBag)
        
        tableView.rx.didScroll
            .subscribe(onNext: { [weak self] in
                self?.searchView.textField.resignFirstResponder()
            })
            .disposed(by: disposeBag)
        
        tableView.didSelect
            .subscribe(onNext: { [weak self] city in
                self?.searchView.setup(name: city.name)
                self?.selectedCity = city
            })
            .disposed(by: disposeBag)
        
        rx.keyboardHeight
            .subscribe(onNext: { [weak self] keyboardHeight in
                self?.tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardHeight, right: 0)
            })
            .disposed(by: disposeBag)
        
        button.rx.tap
            .subscribe(onNext: { [weak self] in
                guard let self = self, self.button.style == .skip else {
                    return
                }
                
                self.onNext()
            })
            .disposed(by: disposeBag)
        
        button.rx.tap
            .flatMapLatest { [weak self] _ -> Single<Bool> in
                guard let self = self else {
                    return .never()
                }
                
                guard self.button.style == .next else {
                    return .never()
                }
                
                if let selectedCity = self.selectedCity {
                    return self.userManager
                        .set(city: selectedCity.name)
                        .map { true }
                        .catchAndReturn(false)
                } else {
                    return self.userManager
                        .add(city: self.searchView.textField.text ?? "")
                        .flatMap { city -> Single<Bool> in
                            guard let city = city else {
                                return .just(false)
                            }
                            
                            return self.userManager
                                .set(city: city.name)
                                .map { true }
                                .catchAndReturn(false)
                        }
                }
            }
            .subscribe(onNext: { [weak self] success in
                guard success else {
                    Toast.notify(with: "Onboarding.FailedToSave".localized, style: .danger)
                    return
                }

                self?.onNext()
            })
            .disposed(by: disposeBag)
    }
}

// MARK: Make constraints
private extension OCityView {
    func makeConstraits() {
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16.scale),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16.scale),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: ScreenSize.isIphoneXFamily ? 130.scale : 70.scale)
        ])
        
        NSLayoutConstraint.activate([
            searchView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16.scale),
            searchView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16.scale),
            searchView.heightAnchor.constraint(equalToConstant: 60.scale),
            searchView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 32.scale)
        ])
        
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: 338.scale),
            imageView.heightAnchor.constraint(equalToConstant: 270.scale),
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.topAnchor.constraint(equalTo: searchView.bottomAnchor, constant: 45.scale)
        ])
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16.scale),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16.scale),
            tableView.topAnchor.constraint(equalTo: searchView.bottomAnchor, constant: 8.scale),
            tableView.bottomAnchor.constraint(equalTo: button.topAnchor, constant: -24.scale)
        ])
        
        NSLayoutConstraint.activate([
            button.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 26.scale),
            button.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -26.scale),
            button.heightAnchor.constraint(equalToConstant: 51.scale),
            button.bottomAnchor.constraint(equalTo: bottomAnchor, constant: ScreenSize.isIphoneXFamily ? -60.scale : -20.scale)
        ])
    }
}

// MARK: Lazy initialization
private extension OCityView {
    func makeTitleLabel() -> UILabel {
        let attrs = TextAttributes()
            .textColor(UIColor(integralRed: 31, green: 31, blue: 31))
            .font(Fonts.Qanelas.bold(size: 30.scale))
            .lineHeight(36.scale)
            .textAlignment(.center)
        
        let view = UILabel()
        view.numberOfLines = 0
        view.attributedText = "Onboarding.City.Title".localized.attributed(with: attrs)
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeSearchView() -> CitySearchView {
        let view = CitySearchView()
        view.backgroundColor = UIColor.white
        view.layer.cornerRadius = 4.scale
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeImageView() -> UIImageView {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.image = UIImage(named: "Onboarding.City.Image")
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeTableView() -> CitySearchTableView {
        let view = CitySearchTableView()
        view.separatorStyle = .none
        view.layer.cornerRadius = 4.scale
        view.layer.masksToBounds = true
        view.backgroundColor = UIColor.white
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeButton() -> OCityButton {
        let view = OCityButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
}
