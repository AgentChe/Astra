//
//  SettingsViewModel.swift
//  Astra
//
//  Created by Andrey Chernyshev on 18.08.2021.
//

import RxSwift
import RxCocoa
import OtterScaleiOS

final class SettingsViewModel {
    lazy var elements = makeElements()
    
    private lazy var activeSubscription = makeActiveSubscription()
    
    private lazy var sessionManager = SessionManager()
}

// MARK: Private
private extension SettingsViewModel {
    func makeElements() -> Driver<[SettingsTableElement]> {
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
                let accessValidTill = OtterScale.shared.getAccessValidTill() ?? ""
                
                let subscription = activeSubscription ? [SettingsTableElement.premium(date: accessValidTill)] : [SettingsTableElement.buy]
                
                return subscription + main
            }
    }
    
    func makeActiveSubscription() -> Driver<Bool> {
        PurchaseValidationObserver.shared
            .didValidatedWithActiveSubscription
            .map { SessionManager().hasActiveSubscriptions() }
            .asDriver(onErrorJustReturn: false)
            .startWith(SessionManager().hasActiveSubscriptions())
    }
}
