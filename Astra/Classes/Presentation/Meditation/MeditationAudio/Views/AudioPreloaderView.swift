//
//  AudioPreloaderView.swift
//  Astra
//
//  Created by Andrey Chernyshev on 28.09.2021.
//

import UIKit

final class AudioPreloaderView: UIImageView {
    lazy var preloader = makePreloader()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Public
extension AudioPreloaderView {
    func start() {
        isHidden = false
        preloader.startAnimating()
    }
    
    func stop() {
        isHidden = true
        preloader.stopAnimating()
    }
}

// MARK: Make constraints
private extension AudioPreloaderView {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            preloader.centerXAnchor.constraint(equalTo: centerXAnchor),
            preloader.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}

// MARK: Lazy initialization
private extension AudioPreloaderView {
    func makePreloader() -> UIActivityIndicatorView {
        let view = UIActivityIndicatorView()
        view.style = .whiteLarge
        view.hidesWhenStopped = true
        view.stopAnimating()
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
}
