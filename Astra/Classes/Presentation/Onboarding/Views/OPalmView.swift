//
//  OPalmView.swift
//  Astra
//
//  Created by Andrey Chernyshev on 02.09.2021.
//

import UIKit
import AVFoundation.AVCaptureDevice

class t: UIImagePickerController {
    deinit {
        print("deinit")
    }
}

final class OPalmView: OSlideView {
    lazy var cameraContainer = makeCameraContainer()
    lazy var bottomView = makeBottomView()
    lazy var textLabel = makeTextLabel()
    lazy var takeButton = makeTakeButton()
    lazy var preloaderContainer = makePreloaderContainer()
    lazy var preloader = makePreloader()
    lazy var successLabel = makeSuccessLabel()
    
    private weak var vc: UIViewController?
    
    convenience init(step: OnboardingView.Step, vc: UIViewController?) {
        self.init(step: step)
        
        self.vc = vc
    }
    
    override init(step: OnboardingView.Step) {
        super.init(step: step)
        
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func moveToThis() {
        super.moveToThis()
        
        showCamera()
    }
}

// MARK: Private
private extension OPalmView {
    func showCamera() {
        guard let parentVC = vc else {
            return
        }
        
        let cameraVC = t()
        cameraVC.sourceType = .camera
        cameraVC.showsCameraControls = false
        
        let containerSize = cameraContainer.bounds.size
        let cameraHeight = containerSize.width * 3.0 / 4.0
        let scale = containerSize.height / cameraHeight
        cameraVC.cameraViewTransform = CGAffineTransform(scaleX: scale, y: scale)
        
        parentVC.addChild(cameraVC)
        cameraVC.view.frame = cameraContainer.bounds
        cameraContainer.addSubview(cameraVC.view)
        
        cameraVC.willMove(toParent: parentVC)
    }
    
    @objc
    func take() {
        takeButton.isUserInteractionEnabled = false
        
        preloaderContainer.isHidden = false
        preloader.startAnimating()
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) { [weak self] in
            guard let self = self else {
                return
            }
            
            self.preloaderContainer.isHidden = true
            self.preloader.stopAnimating()
            
            self.successLabel.isHidden = false
            
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) { [weak self] in
                guard let self = self else {
                    return
                }
                
                self.cameraContainer.subviews.forEach { $0.removeFromSuperview() }
                
                self.onNext()
            }
        }
    }
}

// MARK: Make constraints
private extension OPalmView {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            cameraContainer.leadingAnchor.constraint(equalTo: leadingAnchor),
            cameraContainer.trailingAnchor.constraint(equalTo: trailingAnchor),
            cameraContainer.bottomAnchor.constraint(equalTo: bottomView.topAnchor),
            cameraContainer.topAnchor.constraint(equalTo: topAnchor)
        ])
        
        NSLayoutConstraint.activate([
            bottomView.leadingAnchor.constraint(equalTo: leadingAnchor),
            bottomView.trailingAnchor.constraint(equalTo: trailingAnchor),
            bottomView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            textLabel.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor, constant: 16.scale),
            textLabel.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor, constant: -16.scale),
            textLabel.topAnchor.constraint(equalTo: bottomView.topAnchor, constant: 24.scale),
            textLabel.bottomAnchor.constraint(equalTo: takeButton.topAnchor, constant: -16.scale)
        ])
        
        NSLayoutConstraint.activate([
            takeButton.widthAnchor.constraint(equalToConstant: 70.scale),
            takeButton.heightAnchor.constraint(equalToConstant: 70.scale),
            takeButton.centerXAnchor.constraint(equalTo: bottomView.centerXAnchor),
            takeButton.bottomAnchor.constraint(equalTo: bottomView.bottomAnchor, constant: ScreenSize.isIphoneXFamily ? -60.scale : -20.scale)
        ])
        
        NSLayoutConstraint.activate([
            preloaderContainer.centerXAnchor.constraint(equalTo: centerXAnchor),
            preloaderContainer.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            preloader.widthAnchor.constraint(equalToConstant: 35.scale),
            preloader.heightAnchor.constraint(equalToConstant: 35.scale),
            preloader.topAnchor.constraint(equalTo: preloaderContainer.topAnchor, constant: 20.scale),
            preloader.bottomAnchor.constraint(equalTo: preloaderContainer.bottomAnchor, constant: -20.scale),
            preloader.leadingAnchor.constraint(equalTo: preloaderContainer.leadingAnchor, constant: 20.scale),
            preloader.trailingAnchor.constraint(equalTo: preloaderContainer.trailingAnchor, constant: -20.scale)
        ])
        
        NSLayoutConstraint.activate([
            successLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            successLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}

// MARK: Lazy initialization
private extension OPalmView {
    func makeCameraContainer() -> UIView {
        let view = UIView()
        view.backgroundColor = UIColor.clear
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeBottomView() -> UIView {
        let view = UIView()
        view.backgroundColor = UIColor(integralRed: 31, green: 31, blue: 31)
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeTextLabel() -> UILabel {
        let attrs = TextAttributes()
            .font(Fonts.Qanelas.regular(size: 24.scale))
            .lineHeight(31.2.scale)
            .textAlignment(.center)
            .textColor(UIColor(integralRed: 252, green: 252, blue: 252))
        
        let view = UILabel()
        view.numberOfLines = 0
        view.attributedText = "Onboarding.Palm.Text".localized.attributed(with: attrs)
        view.translatesAutoresizingMaskIntoConstraints = false
        bottomView.addSubview(view)
        return view
    }
    
    func makeTakeButton() -> UIButton {
        let view = UIButton()
        view.setImage(UIImage(named: "Onboarding.Palm.Button"), for: .normal)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addTarget(self, action: #selector(take), for: .touchUpInside)
        bottomView.addSubview(view)
        return view
    }
    
    func makePreloaderContainer() -> UIView {
        let view = UIView()
        view.isHidden = true
        view.backgroundColor = UIColor(integralRed: 244, green: 244, blue: 244)
        view.layer.cornerRadius = 7.scale
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makePreloader() -> UIActivityIndicatorView {
        let view = UIActivityIndicatorView()
        view.style = .gray
        view.hidesWhenStopped = true
        view.stopAnimating()
        view.translatesAutoresizingMaskIntoConstraints = false
        preloaderContainer.addSubview(view)
        return view
    }
    
    func makeSuccessLabel() -> PaddingLabel {
        let attrs = TextAttributes()
            .font(Fonts.Qanelas.regular(size: 24.scale))
            .textColor(UIColor.black)
        
        let view = PaddingLabel()
        view.leftInset = 39.scale
        view.rightInset = 39.scale
        view.bottomInset = 21.scale
        view.topInset = 21.scale
        view.isHidden = true
        view.backgroundColor = UIColor(integralRed: 244, green: 244, blue: 244)
        view.layer.cornerRadius = 7.scale
        view.layer.masksToBounds = true
        view.attributedText = "Onboarding.Palm.Success".localized.attributed(with: attrs)
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
}
