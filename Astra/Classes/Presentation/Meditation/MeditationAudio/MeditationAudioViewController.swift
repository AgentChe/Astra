//
//  MeditationAudioViewController.swift
//  Astra
//
//  Created by Andrey Chernyshev on 26.08.2021.
//

import UIKit
import RxSwift

final class MeditationAudioViewController: UIViewController {
    deinit {
        audioPlayer?.clear()
    }
    
    lazy var mainView = MeditationAudioView()
    
    private lazy var disposeBag = DisposeBag()
    
    private lazy var viewModel = MeditationAudioViewModel()
    
    private lazy var audioPlayer = AudioPlayer(audio: audio)
    
    private let audio: MeditationAudio
    
    private init(audio: MeditationAudio) {
        self.audio = audio
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        audioPlayer?.delegate = self
        mainView.fill(audio: audio)
        
        mainView.backButton.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.dismiss(animated: true)
            })
            .disposed(by: disposeBag)
        
        mainView.playPauseButton.rx.tap
            .subscribe(onNext: { [weak self] in
                guard let self = self else {
                    return
                }
                
                switch self.mainView.playPauseButton.stateCode {
                case .play:
                    self.audioPlayer?.pause()
                case .pause:
                    self.audioPlayer?.play()
                }
                
                self.mainView.playPauseButton.invertedState()
            })
            .disposed(by: disposeBag)
        
        mainView.playerBackButton.rx.tap
            .subscribe(onNext: { [weak self] in
//                self?.audioPlayer?.back()
                self?.mainView.preloaderView.start()
                self?.mainView.playPauseButton.isHidden = true
            })
            .disposed(by: disposeBag)
        
        mainView.playerForwardButton.rx.tap
            .subscribe(onNext: { [weak self] in
//                self?.audioPlayer?.forward()
                self?.mainView.preloaderView.stop()
                self?.mainView.playPauseButton.isHidden = false
            })
            .disposed(by: disposeBag)
        
        mainView.slider.rx.controlEvent(.valueChanged)
            .subscribe(onNext: { [weak self] in
                guard let value = self?.mainView.slider.value else {
                    return
                }
                
                self?.audioPlayer?.seek(to: value)
            })
            .disposed(by: disposeBag)
    }
}

// MARK: Make
extension MeditationAudioViewController {
    static func make(audio: MeditationAudio) -> MeditationAudioViewController {
        let vc = MeditationAudioViewController(audio: audio)
        vc.navigationItem.backButtonTitle = " "
        vc.modalPresentationStyle = .fullScreen
        return vc
    }
}

// MARK: AudioPlayerDelegate
extension MeditationAudioViewController: AudioPlayerDelegate {
    func audioPlayer(totalDuration: Float64) {
        mainView.setup(totalDuration: totalDuration)
    }
    
    func audioPlayer(currentTime: Float64) {
        mainView.setup(currentTime: currentTime)
    }
    
    func audioPlayerFinished() {
        mainView.playPauseButton.stateCode = .pause
    }
}
