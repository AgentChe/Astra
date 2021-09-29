//
//  NatalViewController.swift
//  Astra
//
//  Created by Andrey Chernyshev on 29.09.2021.
//

import UIKit
import RxSwift

final class NatalViewController: UIViewController {
    lazy var mainView = NatalView()
    
    private lazy var disposeBag = DisposeBag()
    
    private lazy var viewModel = NatalViewModel()
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.elements.drive(onNext: { [weak self] elements in
            self?.mainView.tableView.setup(elements: elements)
        })
        .disposed(by: disposeBag)
        
        mainView.infoView.closeButton.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.hideInfo()
            })
            .disposed(by: disposeBag)
        
        mainView.tableView.mainDelegate = self
    }
}

// MARK: Make
extension NatalViewController {
    static func make() -> NatalViewController {
        let vc = NatalViewController()
        vc.navigationItem.backButtonTitle = " "
        vc.navigationItem.title = "Natal.Title".localized
        return vc
    }
}

// MARK: NatalTableViewDelegate
extension NatalViewController: NatalTableViewDelegate {
    func natalTableDidTappedWhatAre() {
        showInfo()
    }
    
    func natalTableDidTapped(article: NatalArticle) {
        if SessionManagerCore().getSession()?.activeSubscription == true {
            let vc = NatalDetailsViewController.make(article: article)
            navigationController?.pushViewController(vc, animated: true)
        } else {
            let vc = PaygateViewController.make()
            UIApplication.shared.keyWindow?.rootViewController?.present(vc, animated: true)
        }
    }
}

// MARK: Private
private extension NatalViewController {
    func showInfo() {
        mainView.infoView.isHidden = false
        
        UIView.animate(withDuration: 0.5, animations: { [weak self] in
            self?.mainView.infoView.alpha = 1
        })
    }
    
    func hideInfo() {
        UIView.animate(withDuration: 0.5, animations: { [weak self] in
            self?.mainView.infoView.alpha = 0
        }, completion: { [weak self] _ in
            self?.mainView.infoView.isHidden = true
        })
    }
}
