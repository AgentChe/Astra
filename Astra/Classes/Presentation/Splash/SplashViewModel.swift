//
//  SplashViewModel.swift
//  Astra
//
//  Created by Andrey Chernyshev on 11.08.2021.
//

import RxSwift
import RxCocoa

final class SplashViewModel {
    enum Step {
        case onboarding, main
    }
    
    lazy var step = library()
        .andThen(makeStep())
        .asDriver(onErrorDriveWith: .empty())
    
    private lazy var compatibilityManager = CompatibilityManagerCore()
}

// MARK: Private
private extension SplashViewModel {
    func library() -> Completable {
        compatibilityManager
            .obtainCompatibilities(forceUpdate: true)
            .asCompletable()
    }
    
    func makeStep() -> Single<Step> {
        guard OnboardingViewController.wasViewed() else {
            return .deferred { .just(.onboarding) }
        }
        
        return .deferred { .just(.main) }
    }
}
