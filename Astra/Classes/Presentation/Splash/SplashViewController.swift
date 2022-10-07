//
//  SplashViewController.swift
//  Astra
//
//  Created by Andrey Chernyshev on 11.08.2021.
//

import UIKit
import RxSwift
import RxCocoa

final class SplashViewController: UIViewController {
    lazy var mainView = SplashView()
    
    private lazy var disposeBag = DisposeBag()
    
    private lazy var viewModel = SplashViewModel()
    
    private lazy var validationObserver = SplashReceiptValidationObserver()
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.animationView.loopMode = .loop
        mainView.animationView.play()
        
        validationObserver.observe { [weak self] in
            self?.viewModel.validationComplete.accept(Void())
        }
        
        viewModel.step()
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
            UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.rootViewController = OnboardingViewController.make()
        case .main:
            UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.rootViewController = TabController.make()
        case .paygate:
            let vc = PaygateViewController.make { result in
                UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.rootViewController = TabController.make()
            }
            present(vc, animated: true)
        }
    }
}
