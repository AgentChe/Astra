//
//  TarotViewController.swift
//  Astra
//
//  Created by Andrey Chernyshev on 19.08.2021.
//

import UIKit
import RxSwift

final class TarotViewController: UIViewController {
    lazy var mainView = TarotView(type: type)
    
    private lazy var disposeBag = DisposeBag()
    
    private lazy var viewModel = TarotViewModel()
    
    private let type: TarotType
    
    private init(type: TarotType) {
        self.type = type
        
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
        
        mainView.tableView.vc = self
        
        mainView.backButton.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.dismiss(animated: true)
            })
            .disposed(by: disposeBag)
        
        viewModel.elements
            .drive(onNext: { [weak self] elements in
                self?.mainView.tableView.setup(elements: elements)
            })
            .disposed(by: disposeBag)
    }
}

// MARK: TarotTableViewDelegate
extension TarotViewController: TarotTableViewDelegate {
    func taroTableViewDidSelect(imagePath: String, isReversed: Bool, in rect: CGRect) {
        let fullTarotView = UIImageView()
        fullTarotView.frame = rect
        fullTarotView.contentMode = .scaleAspectFit
        fullTarotView.clipsToBounds = true
        
        mainView.addSubview(fullTarotView)
        
        let tapGesture = UITapGestureRecognizer()
        fullTarotView.isUserInteractionEnabled = true
        fullTarotView.addGestureRecognizer(tapGesture)
        
        ImageLoader.setup(in: fullTarotView,
                          imageUrl: imagePath,
                          orientation: isReversed ? .downMirrored : .none)
        
        tapGesture.rx.event
            .subscribe(onNext: { [weak self] _ in
                self?.fullImageTapped(fullTarotView: fullTarotView, sourceFrame: rect)
            })
            .disposed(by: disposeBag)
        
        UIView.animate(withDuration: 0.5, animations: { [weak self] in
            guard let self = self else {
                return
            }
            
            self.mainView.backButton.alpha = 0
            self.mainView.titleLabel.alpha = 0
            self.mainView.tableView.alpha = 0
            
            fullTarotView.frame.size = CGSize(width: 250.scale, height: 566.scale)
            fullTarotView.center = self.mainView.center
        })
    }
}

// MARK: Make
extension TarotViewController {
    static func make(type: TarotType) -> TarotViewController {
        let vc = TarotViewController(type: type)
        vc.viewModel.tarotType.accept(type)
        vc.modalPresentationStyle = .fullScreen
        return vc
    }
}

// MARK: Private
private extension TarotViewController {
    func fullImageTapped(fullTarotView: UIImageView, sourceFrame: CGRect) {
        UIView.animate(withDuration: 0.5, animations: { [weak self] in
            guard let self = self else {
                return
            }
            
            self.mainView.backButton.alpha = 1
            self.mainView.titleLabel.alpha = 1
            self.mainView.tableView.alpha = 1
            
            fullTarotView.frame = sourceFrame
        }, completion: { _ in
            fullTarotView.removeFromSuperview()
        })
    }
}
