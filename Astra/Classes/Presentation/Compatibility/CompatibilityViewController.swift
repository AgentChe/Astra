//
//  CompatibilityViewController.swift
//  Astra
//
//  Created by Andrey Chernyshev on 23.08.2021.
//

import UIKit
import RxSwift

final class CompatibilityViewController: UIViewController {
    lazy var mainView = CompatibilityView()
    
    private lazy var disposeBag = DisposeBag()
    
    private lazy var viewModel = CompatibilityViewModel()
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.elements
            .drive(onNext: { [weak self] elements in
                self?.mainView.tableView.setup(elements: elements)
            })
            .disposed(by: disposeBag)
    }
}

// MARK: Make
extension CompatibilityViewController {
    static func make() -> CompatibilityViewController {
        let vc = CompatibilityViewController()
        vc.navigationItem.backButtonTitle = " "
        vc.navigationItem.title = "Compatibility.Title".localized
        return vc
    }
}
