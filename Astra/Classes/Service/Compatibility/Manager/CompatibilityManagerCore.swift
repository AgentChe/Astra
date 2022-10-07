//
//  CompatibilityManagerCore.swift
//  Astra
//
//  Created by Andrey Chernyshev on 22.08.2021.
//

import RxSwift

final class CompatibilityManagerCore: CompatibilityManager {
    enum Constants {
        static let compatibilitiesKey = "compatibility_manager_core_comaptibilities_key"
        static let compatibilitySignsKey = "compatibility_manager_core_compatibility_signs_key"
    }
    
    private let defaultRequestWrapper = DefaultRequestWrapper()
}

// MARK: Public
extension CompatibilityManagerCore {
    func obtainCompatibilities(forceUpdate: Bool) -> Single<[Compatibilities]> {
        guard let userToken = SessionManager().getSession()?.userToken else {
            return .error(SignError.tokenNotFound)
        }
        
        guard forceUpdate else {
            return getCached()
        }
        
        let request = GetCompatibilitiesRequest(userToken: userToken,
                                                locale: UIDevice.deviceLanguageCode ?? "en")
        
        return defaultRequestWrapper
            .callServerApi(requestBody: request)
            .map { GetCompatibilitiesResponse.map(from: $0) }
            .flatMap { [weak self] compatibilities -> Single<[Compatibilities]> in
                guard let self = self else {
                    return .just(compatibilities)
                }
                
                return self.store(compatibilities: compatibilities)
            }
    }
    
    func obtainCompatibility(forceUpdate: Bool, signCode1: Sign.Code, signCode2: Sign.Code) -> Single<Compatibility?> {
        obtainCompatibilities(forceUpdate: forceUpdate)
            .map { [weak self] compatibilies -> Compatibility? in
                guard let self = self else {
                    return nil
                }
                
                return self.find(signCode1: signCode1,
                                 signCode2: signCode2,
                                 compatibilities: compatibilies)
            }
    }
    
    func store(selected signs: CompatibilitySigns) -> Single<Void> {
        guard let data = try? JSONEncoder().encode(signs) else {
            return .error(RxError.unknown)
        }
        
        return Single<Void>
            .create { event in
                UserDefaults.standard.setValue(data, forKey: Constants.compatibilitySignsKey)
                
                event(.success(Void()))
                
                return Disposables.create()
            }
    }
    
    func getSelectedSigns() -> Single<CompatibilitySigns?> {
        guard
            let data = UserDefaults.standard.data(forKey: Constants.compatibilitySignsKey),
            let signs = try? JSONDecoder().decode(CompatibilitySigns.self, from: data)
        else {
            return .deferred { .just(nil) }
        }
        
        return .deferred { .just(signs) }
    }
}

// MARK: Private
private extension CompatibilityManagerCore {
    func getCached() -> Single<[Compatibilities]> {
        Single<[Compatibilities]>
            .create { event in
                guard
                    let data = UserDefaults.standard.data(forKey: Constants.compatibilitiesKey),
                    let compatibilities = try? JSONDecoder().decode([Compatibilities].self, from: data)
                else {
                    event(.success([]))
                    return Disposables.create()
                }
                
                event(.success(compatibilities))
                
                return Disposables.create()
            }
    }
    
    func store(compatibilities: [Compatibilities]) -> Single<[Compatibilities]> {
        Single<[Compatibilities]>
            .create { event in
                guard let data = try? JSONEncoder().encode(compatibilities) else {
                    event(.success(compatibilities))
                    return Disposables.create()
                }
                
                UserDefaults.standard.setValue(data, forKey: Constants.compatibilitiesKey)
                
                event(.success(compatibilities))
                
                return Disposables.create()
            }
    }
    
    func find(signCode1: Sign.Code, signCode2: Sign.Code, compatibilities: [Compatibilities]) -> Compatibility? {
        if
            let compatibilitiesForSign1 = compatibilities.first(where: { $0.signCode == signCode1 }),
            let compatibilityAtSign2 = compatibilitiesForSign1.matches[signCode2] {
            return compatibilityAtSign2
        } else if
            let compatibilitiesForSign2 = compatibilities.first(where: { $0.signCode == signCode2 }),
            let compatibilityAtSign1 = compatibilitiesForSign2.matches[signCode1] {
            return compatibilityAtSign1
        } else {
            return nil
        }
    }
}
