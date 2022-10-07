//
//  ChooseTarotViewController.swift
//  Astra
//
//  Created by Andrey Chernyshev on 19.08.2021.
//

import UIKit
import RxSwift

final class ChooseTarotViewController: UIViewController {
    lazy var mainView = ChooseTarotView(type: type)
    
    private lazy var disposeBag = DisposeBag()
    
    private lazy var viewModel = ChooseTarotViewModel()
    
    private let type: TarotType
    
    override func loadView() {
        view = mainView
    }
    
    private init(type: TarotType) {
        self.type = type
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.backButton.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.dismiss(animated: true)
            })
            .disposed(by: disposeBag)
        
        mainView.button.rx.tap
            .subscribe(onNext: { [weak self] in
                guard let self = self else {
                    return
                }
                
                self.dismiss(animated: false) {
                    let vc = TarotViewController.make(type: self.type)
                    UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.rootViewController?.present(vc, animated: true)
                }
            })
            .disposed(by: disposeBag)
    }
}

// MARK: Make
extension ChooseTarotViewController {
    static func make(type: TarotType) -> ChooseTarotViewController {
        let vc = ChooseTarotViewController(type: type)
        vc.modalPresentationStyle = .fullScreen
        return vc
    }
}
