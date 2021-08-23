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
        
        viewModel.initialSigns
            .drive(onNext: { [weak self] signs in
                guard let self = self, let signs = signs else {
                    return
                }
                
                self.mainView.signs1PickerView.select(sign: signs.signCode1)
                self.mainView.signs2PickerView.select(sign: signs.signCode2)
            })
            .disposed(by: disposeBag)
        
        Observable
            .combineLatest(
                mainView.signs1PickerView.didSelect,
                mainView.signs2PickerView.didSelect
            ) { sign1, sign2 -> CompatibilitySigns in
                CompatibilitySigns(signCode1: sign1, signCode2: sign2)
            }
            .bind(to: viewModel.store)
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
