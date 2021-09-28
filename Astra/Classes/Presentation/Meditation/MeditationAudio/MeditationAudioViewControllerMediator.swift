//
//  MeditationAudioViewControllerMediator.swift
//  Astra
//
//  Created by Andrey Chernyshev on 29.09.2021.
//

protocol MeditationAudioViewControllerMediatorDelegate: AnyObject {
    func meditationAudioViewControllerDidAppear(with audio: MeditationAudio)
    func meditationAudioViewControllerDidDisappear()
}

final class MeditationAudioViewControllerMediator {
    static let shared = MeditationAudioViewControllerMediator()
    
    private init() {}
    
    private lazy var delegates = [Weak<MeditationAudioViewControllerMediatorDelegate>]()
}

// MARK: Public
extension MeditationAudioViewControllerMediator {
    func notifyAboutAppear(with audio: MeditationAudio) {
        delegates.forEach { $0.weak?.meditationAudioViewControllerDidAppear(with: audio) }
    }
    
    func notifyAboutDisappear() {
        delegates.forEach { $0.weak?.meditationAudioViewControllerDidDisappear() }
    }
}

// MARK: Observer
extension MeditationAudioViewControllerMediator {
    func add(delegate: MeditationAudioViewControllerMediatorDelegate) {
        let weakly = delegate as AnyObject
        delegates.append(Weak<MeditationAudioViewControllerMediatorDelegate>(weakly))
        delegates = delegates.filter { $0.weak != nil }
    }

    func remove(delegate: MeditationAudioViewControllerMediatorDelegate) {
        if let index = delegates.firstIndex(where: { $0.weak === delegate }) {
            delegates.remove(at: index)
        }
    }
}
