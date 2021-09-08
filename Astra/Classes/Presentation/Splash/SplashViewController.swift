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
    
    private let generateStep: Signal<Void>
    
    private init(generateStep: Signal<Void>) {
        self.generateStep = generateStep
        
        super.init(nibName: nil, bundle: .main)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let animation = generateStep
            .flatMapLatest { _ -> Driver<Void> in
                Single<Void>
                    .create { [weak self] event in
                        guard let self = self else {
                            return Disposables.create()
                        }
                        
                        self.mainView.animationView.play { _ in
                            event(.success(Void()))
                        }
                        
                        return Disposables.create()
                    }
                    .asDriver(onErrorDriveWith: .empty())
            }
        
        let step = generateStep
            .delay(RxTimeInterval.seconds(1))
            .flatMap { [weak self] in
                self?.viewModel.step ?? .empty()
            }
        
        Driver
            .zip(animation, step)
            .map { $1 }
            .drive(onNext: { [weak self] step in
                self?.handle(step: step)
            })
            .disposed(by: disposeBag)
    }
}

// MARK: Make
extension SplashViewController {
    static func make(generateStep: Signal<Void>) -> SplashViewController {
        SplashViewController(generateStep: generateStep)
    }
}

// MARK: Private
private extension SplashViewController {
    func handle(step: SplashViewModel.Step) {
        switch step {
        case .onboarding:
            UIApplication.shared.keyWindow?.rootViewController = OnboardingViewController.make()
        case .main:
            UIApplication.shared.keyWindow?.rootViewController = TabController.make()
        case .paygate:
            let vc = PaygateViewController.make { result in
                UIApplication.shared.keyWindow?.rootViewController = TabController.make()
            }
            present(vc, animated: true)
        }
    }
}
