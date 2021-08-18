//
//  LunarViewController.swift
//  Astra
//
//  Created by Andrey Chernyshev on 18.08.2021.
//

import UIKit
import RxSwift

final class LunarViewController: UIViewController {
    lazy var mainView = LunarView()
    
    private lazy var disposeBag = DisposeBag()
    
    private lazy var viewModel = LunarViewModel()
    
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
        
        mainView.backButton.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.dismiss(animated: true)
            })
            .disposed(by: disposeBag)
    }
}

// MARK: Make
extension LunarViewController {
    static func make() -> LunarViewController {
        let vc = LunarViewController()
        vc.navigationItem.title = "Lunar.Title".localized
        vc.modalPresentationStyle = .fullScreen
        vc.navigationItem.backButtonTitle = " "
        return vc
    }
}
