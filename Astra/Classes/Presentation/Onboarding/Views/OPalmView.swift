//
//  OPalmView.swift
//  Astra
//
//  Created by Andrey Chernyshev on 02.09.2021.
//

import UIKit

final class OPalmView: OSlideView {
    override init(step: OnboardingView.Step) {
        super.init(step: step)
        
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Make constraints
private extension OPalmView {
    func makeConstraints() {
        
    }
}

// MARK: Lazy initialization
private extension OPalmView {
    
}
