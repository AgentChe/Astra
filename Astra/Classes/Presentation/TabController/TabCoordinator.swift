//
//  TabCoordinator.swift
//  Astra
//
//  Created by Andrey Chernyshev on 13.08.2021.
//

import UIKit

final class TabCoordinator {
    weak var parentVC: TabController?
    
    lazy var horoVC = NavigationController(rootViewController: MainViewController.make())
    lazy var meditationsVC = NavigationController(rootViewController: MeditationsDashboardViewController.make())
    lazy var compatibilityVC = NavigationController(rootViewController: CompatibilitySignsViewController.make())
    lazy var biorhythmsVC = NavigationController(rootViewController: BiorhythmsViewController.make())
    
    private var previousVC: UIViewController?
    
    init(parentVC: TabController) {
        self.parentVC = parentVC
    }
    
    func change(tab: TabView.Tab) {
        parentVC?.mainView.tabView.selectedTab = tab
        
        switch tab {
        case .horo:
            changeVC(on: horoVC)
        case .meditations:
            changeVC(on: meditationsVC)
        case .compatibility:
            changeVC(on: compatibilityVC)
        case .biorhythms:
            changeVC(on: biorhythmsVC)
        }
    }
}

// MARK: Private
private extension TabCoordinator {
    func changeVC(on vc: UIViewController) {
        if let previousVC = self.previousVC {
            previousVC.willMove(toParent: nil)
            previousVC.view.removeFromSuperview()
            previousVC.removeFromParent()
        }
    
        self.previousVC = vc
        
        guard let parentVC = self.parentVC else {
            return
        }
    
        parentVC.addChild(vc)
        vc.view.frame = parentVC.mainView.container.bounds
        parentVC.mainView.container.addSubview(vc.view)
        vc.willMove(toParent: parentVC)
    }
}
