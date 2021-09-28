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
        let session = makeSession()
        
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
            .combineLatest(session, main) { session, main -> [SettingsTableElement] in
                let activeSubscription = session?.activeSubscription ?? false
                let accessValidTill = session?.accessValidTill ?? ""
                
                let subscription = activeSubscription ? [SettingsTableElement.premium(date: accessValidTill)] : [SettingsTableElement.buy]
                
                return subscription + main
            }
    }
    
    func makeSession() -> Driver<Session?> {
        let updated = SDKStorage.shared
            .purchaseMediator
            .rxPurchaseMediatorDidValidateReceipt
            .map { response -> Session? in
                guard let response = response else {
                    return nil
                }
                
                return Session(response: response)
            }
            .asDriver(onErrorJustReturn: nil)
        
        let initial = Driver<Session?>
            .deferred { [weak self] in
                guard let this = self else {
                    return .never()
                }
                
                let session = this.sessionManager.getSession()
                
                return .just(session)
            }
        
        return Driver
            .merge(initial, updated)
    }
}
