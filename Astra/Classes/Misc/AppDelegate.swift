//
//  AppDelegate.swift
//  Nursing
//
//  Created by Andrey Chernyshev on 16.01.2021.
//

import UIKit
import RxCocoa

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    private lazy var generateStepInSplash = PublishRelay<Void>()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
//        let vc = SplashViewController.make(generateStep: generateStepInSplash.asSignal())
//        window?.rootViewController = vc
        window?.makeKeyAndVisible()
        
        return true
    }
}
