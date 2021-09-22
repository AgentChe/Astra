//
//  SettingsViewModel.swift
//  Astra
//
//  Created by Andrey Chernyshev on 18.08.2021.
//

import RxSwift
import RxCocoa

final class SettingsViewModel {
    lazy var elements = makeElements()
    
    private lazy var sessionManager = SessionManagerCore()
}

// MARK: Private
private extension SettingsViewModel {
    func makeElements() -> Driver<[SettingsTableElement]> {
        let activeSubscription = makeActiveSubscription()
        
        let main = Driver<[SettingsTableElement]>.deferred {
            return .just([
                .offset(24.scale),
                .rateUs(title: "Settings.RateUs".localized),
                .offset(12.scale),
                .link(title: "Settings.ContactUs".localized, path: GlobalDefinitions.contactUsUrl),
                .offset(12.scale),
                .link(title: "Settings.TermsOfuse".localized, path: GlobalDefinitions.termsOfServiceUrl),
                .offset(12.scale),
                .link(title: "Settings.PrivacyPolicy".localized, path: GlobalDefinitions.privacyPolicyUrl)
            ])
        }
        
        return Driver
            .combineLatest(activeSubscription, main) { activeSubscription, main -> [SettingsTableElement] in
                let subscription = activeSubscription ? [SettingsTableElement.premium] : [SettingsTableElement.buy]
                
                return subscription + main
            }
    }
    
    func makeActiveSubscription() -> Driver<Bool> {
        let updated = SDKStorage.shared
            .purchaseMediator
            .rxPurchaseMediatorDidValidateReceipt
            .compactMap { $0?.activeSubscription }
            .asDriver(onErrorJustReturn: false)
        
        let initial = Driver<Bool>
            .deferred { [weak self] in
                guard let this = self else {
                    return .never()
                }
                
                let activeSubscription = this.sessionManager.getSession()?.activeSubscription ?? false
                
                return .just(activeSubscription)
            }
        
        return Driver
            .merge(initial, updated)
    }
}
