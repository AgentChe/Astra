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
}

// MARK: Private
private extension SettingsViewModel {
    func makeElements() -> Driver<[SettingsTableElement]> {
        return .deferred {
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
    }
}
