//
//  TabController.swift
//  Astra
//
//  Created by Andrey Chernyshev on 13.08.2021.
//
import UIKit
import RxSwift

final class TabController: UIViewController {
    var mainView = TabMainView()
    
    private lazy var disposeBag = DisposeBag()
    
    private lazy var coordinator = TabCoordinator(parentVC: self)
    
    override func loadView() {
        super.loadView()
        
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addActionsToTabs()
        
        rx.methodInvoked(#selector(UIViewController.viewDidLayoutSubviews))
            .take(1)
            .subscribe(onNext: { [weak self] _ in
                self?.update(selectedTab: .horo)
            })
            .disposed(by: disposeBag)
    }
}

// MARK: Make
extension TabController {
    static func make() -> TabController {
        TabController()
    }
}
 
// MARK: Private
private extension TabController {
    func addActionsToTabs() {
        let horoGesture = UITapGestureRecognizer()
        mainView.tabView.horoItem.isUserInteractionEnabled = true
        mainView.tabView.horoItem.addGestureRecognizer(horoGesture)
        
        let meditationsGesture = UITapGestureRecognizer()
        mainView.tabView.meditationsItem.isUserInteractionEnabled = true
        mainView.tabView.meditationsItem.addGestureRecognizer(meditationsGesture)
        
        let compatibilityGesture = UITapGestureRecognizer()
        mainView.tabView.compatibilityItem.isUserInteractionEnabled = true
        mainView.tabView.compatibilityItem.addGestureRecognizer(compatibilityGesture)
        
        let biorhythmsGesture = UITapGestureRecognizer()
        mainView.tabView.biorhythmsItem.isUserInteractionEnabled = true
        mainView.tabView.biorhythmsItem.addGestureRecognizer(biorhythmsGesture)
        
        Observable
            .merge([
                horoGesture.rx.event.map { _ in TabView.Tab.horo },
                meditationsGesture.rx.event.map { _ in TabView.Tab.meditations },
                compatibilityGesture.rx.event.map { _ in TabView.Tab.compatibility },
                biorhythmsGesture.rx.event.map { _ in TabView.Tab.biorhythms }
            ])
            .subscribe(onNext: { [weak self] tab in
                self?.update(selectedTab: tab)
            })
            .disposed(by: disposeBag)
    }
    
    func update(selectedTab: TabView.Tab) {
        coordinator.change(tab: selectedTab)
    }
}
