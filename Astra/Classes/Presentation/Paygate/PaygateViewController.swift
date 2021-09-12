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
        
        viewModel.paygate.drive(onNext: { [weak self] paygate in
            self?.mainView.optionView1.option = paygate.first
            self?.mainView.optionView2.option = paygate.second
        })
        .disposed(by: disposeBag)
        
        mainView.optionView1.isSelected = true
        mainView.optionView2.isSelected = false
        
        addOptionActions()
        animateScrollReviews()
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
    func animateScrollReviews() {
        let no = mainView.reviewsView.contentOffset.x + 1
        
        UIView.animate(withDuration: 0.001, delay: 0, options: [.curveEaseInOut], animations: { [weak self] in
            self?.mainView.reviewsView.contentOffset = CGPoint(x: no, y: 0)
        }, completion: { [weak self] _ in
            self?.animateScrollReviews()
        })
    }
    
    func addOptionActions() {
        let option1TapGesture = UITapGestureRecognizer()
        mainView.optionView1.isUserInteractionEnabled = true
        mainView.optionView1.addGestureRecognizer(option1TapGesture)
        
        let option2TapGesture = UITapGestureRecognizer()
        mainView.optionView2.isUserInteractionEnabled = true
        mainView.optionView2.addGestureRecognizer(option2TapGesture)
        
        Observable
            .merge(
                option1TapGesture.rx.event
                    .map { _ in (true, false) },
                
                option2TapGesture.rx.event
                    .map { _ in (false, true) }
            )
            .subscribe(onNext: { [weak self] opt1, opt2 in
                self?.mainView.optionView1.isSelected = opt1
                self?.mainView.optionView2.isSelected = opt2
            })
            .disposed(by: disposeBag)
    }
}
