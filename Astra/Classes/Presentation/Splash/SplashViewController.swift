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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.step
            .delay(RxTimeInterval.seconds(1))
            .drive(onNext: { [weak self] step in
                self?.handle(step: step)
            })
            .disposed(by: disposeBag)
    }
}

// MARK: Make
extension SplashViewController {
    static func make() -> SplashViewController {
        SplashViewController()
    }
}

// MARK: Private
private extension SplashViewController {
    func handle(step: SplashViewModel.Step) {
        switch step {
        case .onboarding:
            let vc = OnboardingViewController.make()
            UIApplication.shared.keyWindow?.rootViewController = vc
        case .main:
            break
        }
    }
}
