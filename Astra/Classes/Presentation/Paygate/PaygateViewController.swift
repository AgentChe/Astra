//
//  PaygateViewController.swift
//  Astra
//
//  Created by Andrey Chernyshev on 08.09.2021.
//

import UIKit
import RxSwift
import RxCocoa

final class PaygateViewController: UIViewController {
    enum Result {
        case bought, canceled
    }
    
    lazy var mainView: PaygateView = {
        let config = PaygateManagerCore().cachedConfig() ?? PaygateConfig.default()
        
        switch config.variant {
        case 1:
            return Paygate1View()
        case 2:
            return Paygate2View()
        case 3:
            return Paygate1View()
        case 4:
            return Paygate1View()
        default:
            return Paygate1View()
        }
    }()
    
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
        
        mainView.didCloseTapped
            .subscribe(onNext: { [weak self] in
                guard let self = self else {
                    return
                }
                
                self.dismiss(animated: true) {
                    self.complete?(.canceled)
                }
            })
            .disposed(by: disposeBag)
        
        viewModel.step
            .drive(onNext: { [weak self] step in
                self?.handle(step: step)
            })
            .disposed(by: disposeBag)
        
        mainView.didRestoreTapped
            .bind(to: viewModel.restore)
            .disposed(by: disposeBag)
        
        mainView.didSubscribeTapped
            .subscribe(onNext: { [weak self] productId in
                guard let self = self else {
                    return
                }
                
                self.viewModel.buy.accept(productId)
            })
            .disposed(by: disposeBag)
        
        viewModel.activityIndicator
            .drive(onNext: { [weak self] activity in
                self?.mainView.activity(activity)
            })
            .disposed(by: disposeBag)
        
        mainView.viewDidLoad()
        downloadPaygate()
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

// MARK: Private
private extension PaygateViewController {
    func handle(step: PaygateViewModel.Step) {
        switch step {
        case .buyed, .restored:
            self.dismiss(animated: true) {
                self.complete?(.bought)
            }
        case .error:
            Toast.notify(with: "Paygate.Error".localized, style: .danger)
        case .canceled:
            break
        }
    }
    
    func downloadPaygate() {
        let config = PaygateManagerCore().cachedConfig() ?? PaygateConfig.default()
        
        switch config.variant {
        case 1:
            viewModel.paygate.drive(onNext: { [weak self] paygate in
                guard let view = self?.mainView as? Paygate1View else {
                    return
                }
                
                view.optionView1.option = paygate.first
                view.optionView2.option = paygate.second
            })
            .disposed(by: disposeBag)
        case 2, 3, 4:
            viewModel.paygate2.drive(onNext: { [weak self] paygate in
                guard let view = self?.mainView as? Paygate2View else {
                    return
                }
                
                view.firstOptionView.option = paygate.first
                view.secondOptionView.option = paygate.second
                view.thirdOptionView.option = paygate.third
            })
            .disposed(by: disposeBag)
        default:
            break
        }
    }
}
