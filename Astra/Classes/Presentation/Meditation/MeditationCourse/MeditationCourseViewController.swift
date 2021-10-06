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
            .subscribe(onNext: { element in
                if element.needPayment {
                    let vc = PaygateViewController.make()
                    UIApplication.shared.keyWindow?.rootViewController?.present(vc, animated: true)
                } else {
                    let vc = MeditationAudioViewController.make(audio: element.audio)
                    UIApplication.shared.keyWindow?.rootViewController?.present(vc, animated: true)
                }
            })
            .disposed(by: disposeBag)
        
        mainView.tableView.rx.contentOffset
            .subscribe(onNext: { [weak self] offset in
                self?.updateTopView(at: offset.y)
            })
            .disposed(by: disposeBag)
        
        updateTopView(at: 0)
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

// MARK: Private
private extension MeditationCourseViewController {
    func updateTopView(at offset: CGFloat) {
        var height = offset * (88.scale / 301.scale)
        height = min(height, 88.scale)
        height = max(height, 0)
        mainView.topView.frame.size.height = height
        
        let k = CGFloat(221) / CGFloat(302)
        var integral = CGFloat(252) - (k * offset)
        if integral < 31 {
            integral = 31
        } else if integral > 252 {
            integral = 252
        }
        let color = UIColor(integralRed: integral, green: integral, blue: integral)
        navigationController?.navigationBar.tintColor = color
    }
}
