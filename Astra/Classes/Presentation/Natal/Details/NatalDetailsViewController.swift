//
//  NatalDetailsViewController.swift
//  Astra
//
//  Created by Andrey Chernyshev on 29.09.2021.
//

import UIKit
import RxSwift

final class NatalDetailsViewController: UIViewController {
    lazy var mainView = NatalDetailsView()
    
    private lazy var disposeBag = DisposeBag()
    
    private lazy var viewModel = NatalDetailsViewModel()
    
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
    }
}

// MARK: Make
extension NatalDetailsViewController {
    static func make(article: NatalArticle) -> NatalDetailsViewController {
        let vc = NatalDetailsViewController()
        vc.viewModel.article.accept(article)
        vc.navigationItem.backButtonTitle = " "
        vc.navigationItem.title = article.title
        return vc
    }
}
