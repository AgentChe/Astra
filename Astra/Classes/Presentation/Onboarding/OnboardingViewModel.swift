//
//  OnboardingViewModel.swift
//  Nursing
//
//  Created by Andrey Chernyshev on 17.01.2021.
//

import RxSwift
import RxCocoa

final class OnboardingViewModel {
    enum Step {
        case paygate, main
    }
    
    private lazy var sessionManager = SessionManager()
    private lazy var paygateManager = PaygateManagerCore()
    
    func whatNext() -> Step {
        if sessionManager.hasActiveSubscriptions() {
            return .main
        }
        
        let config = paygateManager.cachedConfig() ?? PaygateConfig.default()
        
        return (config.afterOnboarding || config.blockEverything) ? .paygate : .main
    }
}
