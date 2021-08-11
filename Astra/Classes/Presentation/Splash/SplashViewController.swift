//
//  SplashViewController.swift
//  Astra
//
//  Created by Andrey Chernyshev on 11.08.2021.
//

import UIKit
import RxSwift

final class SplashViewController: UIViewController {
    lazy var mainView = SplashView()
    
    private lazy var disposeBag = DisposeBag()
    
    private lazy var viewModel = SplashViewModel()
    
    override func loadView() {
        view = mainView
    }
}

// MARK: Make
extension SplashViewController {
    static func make() -> SplashViewController {
        SplashViewController()
    }
}
