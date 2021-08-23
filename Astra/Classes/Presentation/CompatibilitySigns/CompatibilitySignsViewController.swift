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
