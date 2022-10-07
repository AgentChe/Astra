//
//  TarotManagerCore.swift
//  Astra
//
//  Created by Andrey Chernyshev on 19.08.2021.
//

import RxSwift

final class TarotManagerCore: TarotManager {
    private let defaultRequestWrapper = DefaultRequestWrapper()
}

// MARK: Public
extension TarotManagerCore {
    func hasTarotOnToday(with type: TarotType) -> Bool {
        let key = type.rawValue
        
        guard
            let data = UserDefaults.standard.data(forKey: key),
            let cache = try? JSONDecoder().decode(TarotCache.self, from: data)
        else {
            return false
        }
        
        return Calendar.current.isDateInToday(cache.date)
    }
    
    func obtainTarot(with type: TarotType, forceUpdate: Bool) -> Single<Tarot?> {
        guard let userToken = SessionManager().getSession()?.userToken else {
            return .error(SignError.tokenNotFound)
        }
        
        guard forceUpdate else {
            return getCache(for: type)
        }
        
        let request = GetTarotRequest(userToken: userToken,
                                      locale: UIDevice.deviceLanguageCode ?? "en",
                                      type: type.code)
        
        return defaultRequestWrapper
            .callServerApi(requestBody: request)
            .map { GetTarotResponse.map(from: $0, type: type) }
            .flatMap { [weak self] tarot -> Single<Tarot?> in
                guard let self = self, let tarot = tarot else {
                    return .just(tarot)
                }
                
                return self.store(tarot: tarot)
            }
    }
}

// MARK: Private
private extension TarotManagerCore {
    func getCache(for type: TarotType) -> Single<Tarot?> {
        Single<Tarot?>
            .create { event in
                let key = type.rawValue
                
                guard
                    let data = UserDefaults.standard.data(forKey: key),
                    let cache = try? JSONDecoder().decode(TarotCache.self, from: data)
                else {
                    event(.success(nil))
                    return Disposables.create()
                }
                
                guard Calendar.current.isDateInToday(cache.date) else {
                    event(.success(nil))
                    return Disposables.create()
                }
                
                event(.success(cache.tarot))
                
                return Disposables.create()
            }
    }
    
    func store(tarot: Tarot) -> Single<Tarot?> {
        Single<Tarot?>
            .create { event in
                let key = tarot.type.rawValue
                let cache = TarotCache(date: Date(), tarot: tarot)
                
                guard let data = try? JSONEncoder().encode(cache) else {
                    event(.success(tarot))
                    return Disposables.create()
                }
                
                UserDefaults.standard.setValue(data, forKey: key)
                
                event(.success(tarot))
                
                return Disposables.create()
            }
    }
}

// MARK: Private (Model)
private extension TarotManagerCore {
    struct TarotCache: Codable {
        let date: Date
        let tarot: Tarot
    }
}
