//
//  TabPlayerPlayPauseView.swift
//  Astra
//
//  Created by Andrey Chernyshev on 28.09.2021.
//

import UIKit

final class TabPlayerPlayPauseView: UIButton {
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
private extension TabPlayerPlayPauseView {
    func update() {
        switch stateCode {
        case .play:
            setImage(UIImage(named: "Tab.Player.Pause"), for: .normal)
        case .pause:
            setImage(UIImage(named: "Tab.Player.Play"), for: .normal)
        }
    }
}
