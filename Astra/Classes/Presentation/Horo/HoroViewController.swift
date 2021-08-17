//
//  HoroViewController.swift
//  Astra
//
//  Created by Andrey Chernyshev on 17.08.2021.
//

import UIKit
import RxSwift

final class HoroViewController: UIViewController {
    lazy var mainView = HoroView()
    
    private lazy var disposeBag = DisposeBag()
    
    private lazy var viewModel = HoroViewModel()
    
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
        
        mainView.tableView
            .didSelectPeriod
            .bind(to: viewModel.didSelectPeriod)
            .disposed(by: disposeBag)
    }
}

// MARK: Make
extension HoroViewController {
    static func make() -> HoroViewController {
        let vc = HoroViewController()
        vc.navigationItem.backButtonTitle = " "
        vc.navigationItem.title = "Horo.Title".localized
        return vc
    }
}
