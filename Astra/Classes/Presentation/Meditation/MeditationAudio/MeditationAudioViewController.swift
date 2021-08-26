//
//  MeditationAudioViewController.swift
//  Astra
//
//  Created by Andrey Chernyshev on 26.08.2021.
//

import UIKit
import RxSwift

final class MeditationAudioViewController: UIViewController {
    lazy var mainView = MeditationAudioView()
    
    private lazy var disposeBag = DisposeBag()
    
    private lazy var viewModel = MeditationAudioViewModel()
    
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
        
        mainView.fill(audio: audio)
        
        mainView.backButton.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.dismiss(animated: true)
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
