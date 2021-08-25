//
//  MeditationCourseViewController.swift
//  Astra
//
//  Created by Andrey Chernyshev on 25.08.2021.
//

import UIKit
import RxSwift

final class MeditationCourseViewController: UIViewController {
    lazy var mainView = MeditationCourseView()
    
    private lazy var disposeBag = DisposeBag()
    
    private lazy var viewModel = MeditationCourseViewModel()
    
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
        
        mainView.tableView.didSelect
            .subscribe(onNext: { audio in
                print(audio)
            })
            .disposed(by: disposeBag)
    }
}

// MARK: Make
extension MeditationCourseViewController {
    static func make(courseId: Int) -> MeditationCourseViewController {
        let vc = MeditationCourseViewController()
        vc.viewModel.courseId.accept(courseId)
        vc.navigationItem.backButtonTitle = " "
        return vc
    }
}
