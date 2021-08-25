//
//  MeditationsDashboardViewController.swift
//  Astra
//
//  Created by Andrey Chernyshev on 24.08.2021.
//

import UIKit
import RxSwift

final class MeditationsDashboardViewController: UIViewController {
    lazy var mainView = MeditationsDashboardView()
    
    private lazy var disposeBag = DisposeBag()
    
    private lazy var viewModel = MeditationsDashboardViewModel()
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.filters
            .drive(onNext: { [weak self] filters in
                self?.mainView.filtersView.setup(elements: filters)
            })
            .disposed(by: disposeBag)
        
        viewModel.elements
            .drive(onNext: { [weak self] elements in
                self?.mainView.dashboardView.setup(elements: elements)
            })
            .disposed(by: disposeBag)
        
        mainView.filtersView.didSelect
            .bind(to: viewModel.didSelectFilter)
            .disposed(by: disposeBag)
        
        mainView.dashboardView.didSelect
            .subscribe(onNext: { element in
                print(element)
            })
    }
}

// MARK: Make
extension MeditationsDashboardViewController {
    static func make() -> MeditationsDashboardViewController {
        let vc = MeditationsDashboardViewController()
        vc.navigationItem.backButtonTitle = " "
        vc.navigationItem.title = "MeditationsDashboard.Title".localized
        return vc
    }
}
