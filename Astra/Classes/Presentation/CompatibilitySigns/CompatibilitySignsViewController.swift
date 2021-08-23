//
//  CompatibilitySignsViewController.swift
//  Astra
//
//  Created by Andrey Chernyshev on 22.08.2021.
//

import UIKit
import RxSwift

final class CompatibilitySignsViewController: UIViewController {
    lazy var mainView = CompatibilitySignsView()
    
    private lazy var disposeBag = DisposeBag()
    
    private lazy var viewModel = CompatibilitySignsViewModel()
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let initialSigns = viewModel.initialSigns
            .map { signs -> CompatibilitySigns in
                guard let signs = signs else {
                    return CompatibilitySigns(signCode1: .aries,
                                              signCode2: .aries)
                }
                
                return signs
            }
        
        Observable
            .combineLatest(
                mainView.signs1PickerView.didSelect,
                mainView.signs2PickerView.didSelect
            ) { sign1, sign2 -> CompatibilitySigns in
                CompatibilitySigns(signCode1: sign1, signCode2: sign2)
            }
            .flatMapLatest { [weak self] sings -> Completable in
                guard let self = self else {
                    return .never()
                }
                
                return self.viewModel
                    .store(signs: sings)
            }
            .subscribe()
            .disposed(by: disposeBag)
        
        initialSigns
            .drive(onNext: { [weak self] signs in
                guard let self = self else {
                    return
                }
                
                self.mainView.signs1PickerView.select(sign: signs.signCode1)
                self.mainView.signs2PickerView.select(sign: signs.signCode2)
            })
            .disposed(by: disposeBag)
        
        mainView.button.rx.tap
            .subscribe(onNext: { [weak self] in
                let vc = CompatibilityViewController.make()
                self?.navigationController?.pushViewController(vc, animated: true)
            })
            .disposed(by: disposeBag)
    }
}

// MARK: Make
extension CompatibilitySignsViewController {
    static func make() -> CompatibilitySignsViewController {
        let vc = CompatibilitySignsViewController()
        vc.navigationItem.backButtonTitle = " "
        vc.navigationItem.title = "CompatibilitySigns.Title".localized
        return vc
    }
}
