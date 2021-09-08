//
//  PaygateViewController.swift
//  Astra
//
//  Created by Andrey Chernyshev on 08.09.2021.
//

import UIKit
import RxSwift

final class PaygateViewController: UIViewController {
    enum Result {
        case bought, canceled
    }
    
    lazy var mainView = PaygateView()
    
    private lazy var disposeBag = DisposeBag()
    
    private lazy var viewModel = PaygateViewModel()
    
    private let complete: ((Result) -> Void)?
    
    private init(complete: ((Result) -> Void)?) {
        self.complete = complete
        
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
        
        mainView.closeButton.rx.tap
            .subscribe(onNext: { [weak self] in
                guard let self = self else {
                    return
                }
                
                self.dismiss(animated: true) {
                    self.complete?(.canceled)
                }
            })
            .disposed(by: disposeBag)
    }
}

// MARK: Make
extension PaygateViewController {
    static func make(complete: ((Result) -> Void)? = nil) -> PaygateViewController {
        let vc = PaygateViewController(complete: complete)
        vc.modalPresentationStyle = .fullScreen
        return vc
    }
}
