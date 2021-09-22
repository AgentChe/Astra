//
//  PaygateView.swift
//  Astra
//
//  Created by Andrey Chernyshev on 22.09.2021.
//

import UIKit
import RxCocoa

class PaygateView: UIView {
    lazy var didCloseTapped = PublishRelay<Void>()
    lazy var didRestoreTapped = PublishRelay<Void>()
    lazy var didSubscribeTapped = PublishRelay<String>()
    
    func activity(_ isActivity: Bool) {}
    func viewDidLoad() {}
}
