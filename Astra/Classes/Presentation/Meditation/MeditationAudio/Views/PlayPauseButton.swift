//
//  PlayPauseButton.swift
//  Astra
//
//  Created by Andrey Chernyshev on 26.08.2021.
//

import UIKit

final class PlayPauseButton: UIButton {
    enum State {
        case play, pause
    }
    
    var stateCode = State.pause {
        didSet {
            update()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        update()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func invertedState() {
        switch stateCode {
        case .play:
            stateCode = .pause
        case .pause:
            stateCode = .play
        }
    }
}

// MARK: Private
private extension PlayPauseButton {
    func update() {
        switch stateCode {
        case .play:
            setImage(UIImage(named: "MeditationAudio.Player.Pause"), for: .normal)
        case .pause:
            setImage(UIImage(named: "MeditationAudio.Player.Play"), for: .normal)
        }
    }
}
