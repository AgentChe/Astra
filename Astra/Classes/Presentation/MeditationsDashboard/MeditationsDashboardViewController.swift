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
