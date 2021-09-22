//
//  SettingsViewController.swift
//  Astra
//
//  Created by Andrey Chernyshev on 18.08.2021.
//

import UIKit
import RxSwift

final class SettingsViewController: UIViewController {
    lazy var mainView = SettingsView()
    
    private lazy var viewModel = SettingsViewModel()
    
    private lazy var disposeBag = DisposeBag()
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.elements
            .drive(onNext: { [weak self] elements in
                self?.mainView.tableView.setup(elements: elements)
            })
            .disposed(by: disposeBag)
        
        mainView.tableView.mainDelegate = self
    }
}

// MARK: Make
extension SettingsViewController {
    static func make() -> SettingsViewController {
        let vc = SettingsViewController()
        vc.navigationItem.backButtonTitle = " "
        return vc
    }
}

// MARK: SettingsTableViewDelegate
extension SettingsViewController: SettingsTableViewDelegate {
    func settingsTableBuyTapped() {
        let vc = PaygateViewController.make()
        UIApplication.shared.keyWindow?.rootViewController?.present(vc, animated: true)
    }
}
