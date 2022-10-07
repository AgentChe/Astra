//
//  SplashViewModel.swift
//  Astra
//
//  Created by Andrey Chernyshev on 11.08.2021.
//

import RxSwift
import RxCocoa
import OtterScaleiOS

final class SplashViewModel {
    enum Step {
        case onboarding, main, paygate
    }
    
    lazy var validationComplete = PublishRelay<Void>()
    
    func step() -> Driver<Step> {
        handleValidationComplete()
            .flatMap { [weak self] _ -> Observable<Void> in
                guard let self = self else {
                    return .never()
                }
                
                return self.library()
            }
            .flatMap { [weak self] _ -> Observable<Step> in
                guard let self = self else {
                    return .never()
                }
                
                return self.makeStep()
            }
            .asDriver(onErrorDriveWith: .empty())
    }
    
    private lazy var compatibilityManager = CompatibilityManagerCore()
    private lazy var paygateManager = PaygateManagerCore()
    private lazy var sessionManager = SessionManager()
    private lazy var userManager = UserManagerCore()
}

// MARK: Private
private extension SplashViewModel {
    func handleValidationComplete() -> Observable<Void> {
        validationComplete.flatMapLatest { [weak self] _ -> Single<Void> in
            guard let self = self else {
                return .never()
            }
            
            let otterScaleID = OtterScale.shared.getInternalID()
            
            let complete: Single<Void>
            
            if let cachedToken = self.sessionManager.getSession()?.userToken {
                if cachedToken != otterScaleID {
                    complete = self.userManager.syncTokens(oldToken: cachedToken, newToken: otterScaleID)
                } else {
                    complete = .deferred { .just(Void()) }
                }
            } else {
                complete = self.userManager.login(userToken: otterScaleID)
            }
            
            return complete.flatMap { [weak self] _ -> Single<Void> in
                guard let self = self else {
                    return .never()
                }
                
                let session = Session(userToken: otterScaleID)
                self.sessionManager.store(session: session)
                
                return .deferred { .just(Void()) }
            }
        }
    }
    
    func library() -> Observable<Void> {
        let compatibilities = compatibilityManager
            .obtainCompatibilities(forceUpdate: true)
        
        let paygateConfig = paygateManager
            .retrieveConfig(forceUpdate: true)
        
        return Single
            .zip(compatibilities, paygateConfig)
            .mapToVoid()
            .asObservable()
    }
    
    func makeStep() -> Observable<Step> {
        if sessionManager.hasActiveSubscriptions() {
            return .deferred { .just(.main) }
        }
        
        if OnboardingViewController.wasViewed() {
            return .deferred { .just(.paygate) }
        }
        
        return .deferred { .just(.onboarding) }
    }
}
