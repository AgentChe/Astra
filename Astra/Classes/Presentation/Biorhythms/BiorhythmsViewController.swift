//
//  BiorhythmsViewController.swift
//  Astra
//
//  Created by Andrey Chernyshev on 14.09.2021.
//

import UIKit
import RxSwift

final class BiorhythmsViewController: UIViewController {
    lazy var mainView = BiorhythmsView()
    
    private lazy var disposeBag = DisposeBag()
    
    private lazy var viewModel = BiorhythmsViewModel()
    
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
extension BiorhythmsViewController {
    static func make() -> BiorhythmsViewController {
        let vc = BiorhythmsViewController()
        vc.navigationItem.backButtonTitle = " "
        vc.navigationItem.title = "Biorhythms.Title".localized
        return vc
    }
}

// MARK: BiorhythmsTableViewDelegate
extension BiorhythmsViewController: BiorhythmsTableViewDelegate {
    func biorhythmsTableDidTappedWhatAre() {
        showInfo()
    }
}

// MARK: Private
private extension BiorhythmsViewController {
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
