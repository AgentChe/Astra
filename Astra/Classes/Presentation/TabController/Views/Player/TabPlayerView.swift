//
//  TabPlayer.swift
//  Astra
//
//  Created by Andrey Chernyshev on 28.09.2021.
//

import UIKit
import RxSwift

final class TabPlayerView: GradientButton {
    weak var delegate: TabPlayerViewDelegate?
    
    lazy var iconView = makeImageView()
    lazy var label = makeLabel()
    lazy var playPauseButton = makePlayPauseView()
    lazy var closeButton = makeCloseButton()
    
    private var audioPlayer: AudioPlayer?
    
    private lazy var disposeBag = DisposeBag()
    
    private var audio: MeditationAudio?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        makeConstraints()
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Public
extension TabPlayerView {
    func fill(audio: MeditationAudio) {
        self.audio = audio
        
        if let url = URL(string: audio.imageUrl) {
            iconView.kf.setImage(with: url)
        }
        
        label.attributedText = audio.title
            .attributed(with: TextAttributes()
                            .textColor(UIColor.white)
                            .font(Fonts.Qanelas.semiBold(size: 14.scale))
                            .lineHeight(19.6.scale))
    }
    
    func becomeControlOnPlayer() {
        audioPlayer = AudioPlayerManager.shared.player
        audioPlayer?.delegate = self
    }
    
    func resignControlOnPlayer() {
        audioPlayer = nil
        audio = nil
        
        playPauseButton.stateCode = .pause
    }
}

// MARK: AudioPlayerDelegate
extension TabPlayerView: AudioPlayerDelegate {
    func audioPlayer(totalDuration: Float64) {}
    func audioPlayerDidStartPlay() {}
    
    func audioPlayer(currentTime: Float64) {
        if currentTime > 0 && audioPlayer?.isPlaying() == true {
            playPauseButton.stateCode = .play
        }
    }
    
    func audioPlayerFinished() {
        playPauseButton.stateCode = .pause
    }
}

// MARK: Private
private extension TabPlayerView {
    func initialize() {
        gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
        gradientLayer.colors = [
            UIColor(integralRed: 128, green: 221, blue: 216).cgColor,
            UIColor(integralRed: 176, green: 160, blue: 233).cgColor
        ]
        
        playPauseButton.rx.tap
            .subscribe(onNext: { [weak self] in
                guard let self = self else {
                    return
                }
                
                switch self.playPauseButton.stateCode {
                case .play:
                    self.audioPlayer?.pause()
                case .pause:
                    self.audioPlayer?.play()
                }
                
                self.playPauseButton.invertedState()
            })
            .disposed(by: disposeBag)
        
        rx.tap
            .subscribe(onNext: { [weak self] in
                guard let self = self, let audio = self.audio else {
                    return
                }
            
                let vc = MeditationAudioViewController.make(audio: audio)
                UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.rootViewController?.present(vc, animated: true)
            })
            .disposed(by: disposeBag)
        
        closeButton.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.delegate?.tabPlayerDidCloseTapped()
            })
            .disposed(by: disposeBag)
    }
}

// MARK: Make constraints
private extension TabPlayerView {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            iconView.widthAnchor.constraint(equalToConstant: 51.scale),
            iconView.heightAnchor.constraint(equalToConstant: 40.scale),
            iconView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16.scale),
            iconView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            label.centerYAnchor.constraint(equalTo: centerYAnchor),
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 79.scale),
            label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -84.scale)
        ])
        
        NSLayoutConstraint.activate([
            playPauseButton.widthAnchor.constraint(equalToConstant: 40.scale),
            playPauseButton.heightAnchor.constraint(equalToConstant: 40.scale),
            playPauseButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            playPauseButton.trailingAnchor.constraint(equalTo: closeButton.leadingAnchor, constant: -8.scale)
        ])
        
        NSLayoutConstraint.activate([
            closeButton.widthAnchor.constraint(equalToConstant: 24.scale),
            closeButton.heightAnchor.constraint(equalToConstant: 24.scale),
            closeButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            closeButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12.scale)
        ])
    }
}

// MARK: Lazy initialization
private extension TabPlayerView {
    func makeImageView() -> UIImageView {
        let view = UIImageView()
        view.layer.cornerRadius = 4.scale
        view.layer.masksToBounds = true
        view.contentMode = .scaleAspectFill
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeLabel() -> UILabel {
        let view = UILabel()
        view.numberOfLines = 2
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makePlayPauseView() -> TabPlayerPlayPauseView {
        let view = TabPlayerPlayPauseView()
        view.stateCode = .pause
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeCloseButton() -> TapAreaButton {
        let view = TapAreaButton()
        view.setImage(UIImage(named: "Tab.Player.Close"), for: .normal)
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
}
