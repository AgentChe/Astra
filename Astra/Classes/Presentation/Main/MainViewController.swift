//
//  MainViewController.swift
//  Astra
//
//  Created by Andrey Chernyshev on 13.08.2021.
//

import UIKit
import RxSwift

final class MainViewController: UIViewController {
    lazy var mainView = MainView()
    
    private lazy var disposeBag = DisposeBag()
    
    private lazy var viewModel = MainViewModel()
    
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
extension MainViewController {
    static func make() -> MainViewController {
        let vc = MainViewController()
        vc.navigationItem.backButtonTitle = " "
        return vc
    }
}

// MARK: MainTableViewDelegate
extension MainViewController: MainTableViewDelegate {
    func mainTableViewSettingsDidTapped() {
        let vc = SettingsViewController.make()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func mainTableViewHoroDidTapped() {
        let vc = HoroViewController.make()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func mainTableViewBiorhythmsTapped() {
        let vc = BiorhythmsViewController.make()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func mainTableViewLunarDidTapped() {
        let vc = LunarViewController.make()
        UIApplication.shared.keyWindow?.rootViewController?.present(vc, animated: true)
    }
    
    func mainTableViewTarotDidTapped(code: Int) {
        guard let type = TarotType(code: code) else {
            return
        }
        
        if TarotManagerCore().hasTarotOnToday(with: type) {
            let vc = TarotViewController.make(type: type)
            UIApplication.shared.keyWindow?.rootViewController?.present(vc, animated: true)
        } else {
            let vc = ChooseTarotViewController.make(type: type)
            UIApplication.shared.keyWindow?.rootViewController?.present(vc, animated: true)
        }
    }
}
