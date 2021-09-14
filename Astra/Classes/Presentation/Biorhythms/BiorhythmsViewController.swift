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
