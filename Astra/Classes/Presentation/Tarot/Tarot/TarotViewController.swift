//
//  TarotViewController.swift
//  Astra
//
//  Created by Andrey Chernyshev on 19.08.2021.
//

import UIKit
import RxSwift

final class TarotViewController: UIViewController {
    lazy var mainView = TarotView(type: type)
    
    private lazy var disposeBag = DisposeBag()
    
    private lazy var viewModel = TarotViewModel()
    
    private let type: TarotType
    
    private init(type: TarotType) {
        self.type = type
        
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
        
        mainView.backButton.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.dismiss(animated: true)
            })
            .disposed(by: disposeBag)
        
        viewModel.elements
            .drive(onNext: { [weak self] elements in
                self?.mainView.tableView.setup(elements: elements)
            })
            .disposed(by: disposeBag)
    }
}

// MARK: Make
extension TarotViewController {
    static func make(type: TarotType) -> TarotViewController {
        let vc = TarotViewController(type: type)
        vc.viewModel.tarotType.accept(type)
        vc.modalPresentationStyle = .fullScreen
        return vc
    }
}
