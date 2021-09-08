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
        case onboarding, main, paygate
    }
    
    lazy var step = library()
        .andThen(makeStep())
        .asDriver(onErrorDriveWith: .empty())
    
    private lazy var compatibilityManager = CompatibilityManagerCore()
    private lazy var sessionManager = SessionManagerCore()
}

// MARK: Private
private extension SplashViewModel {
    func library() -> Completable {
        compatibilityManager
            .obtainCompatibilities(forceUpdate: true)
            .asCompletable()
    }
    
    func makeStep() -> Single<Step> {
        if let session = sessionManager.getSession(), session.activeSubscription {
            return .deferred { .just(.main) }
        }
        
        if OnboardingViewController.wasViewed() {
            return .deferred { .just(.paygate) }
        }
        
        return .deferred { .just(.onboarding) }
    }
}
