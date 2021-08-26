//
//  MeditationAudioView.swift
//  Astra
//
//  Created by Andrey Chernyshev on 26.08.2021.
//

import UIKit
import Kingfisher
import AVFoundation

final class MeditationAudioView: GradientView {
    lazy var backButton = makeBackButton()
    lazy var imageView = makeImageView()
    lazy var nameLabel = makeLabel()
    lazy var playPauseButton = makePlayPauseButton()
    lazy var playerBackButton = makePlayerBackButton()
    lazy var playerForwardButton = makePlayerForwardButton()
    lazy var slider = makeSlider()
    lazy var currentTimeLabel = makeLabel()
    lazy var totalTimeLabel = makeLabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        makeConstraints()
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Public
extension MeditationAudioView {
    func fill(audio: MeditationAudio) {
        if let url = URL(string: audio.imageUrl) {
            imageView.kf.setImage(with: url)
        }
        
        nameLabel.attributedText = audio.title
            .attributed(with: TextAttributes()
                            .textColor(UIColor(integralRed: 31, green: 31, blue: 31))
                            .font(Fonts.Qanelas.bold(size: 24.scale))
                            .lineHeight(28.8.scale)
                            .textAlignment(.center))
    }
    
    func setup(totalDuration: Float64) {
        slider.minimumValue = 0
        slider.maximumValue = Float(totalDuration)
        
        totalTimeLabel.attributedText = string(from: totalDuration)
            .attributed(with: TextAttributes()
                            .textColor(UIColor(integralRed: 31, green: 31, blue: 31))
                            .font(Fonts.Qanelas.regular(size: 14.scale))
                            .lineHeight(19.6.scale))
    }
    
    func setup(currentTime: Float64) {
        slider.value = Float(currentTime)
        
        currentTimeLabel.attributedText = string(from: currentTime)
            .attributed(with: TextAttributes()
                            .textColor(UIColor(integralRed: 31, green: 31, blue: 31))
                            .font(Fonts.Qanelas.regular(size: 14.scale))
                            .lineHeight(19.6.scale))
    }
}

// MARK: Private
private extension MeditationAudioView {
    func initialize() {
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0, y: 1)
        gradientLayer.colors = [
            UIColor(integralRed: 241, green: 204, blue: 195).cgColor,
            UIColor(integralRed: 226, green: 101, blue: 123).cgColor
        ]
    }
    
    func string(from interval: TimeInterval) -> String {
        let interval = Int(interval)
        let seconds = interval % 60
        let minutes = (interval / 60) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}

// MARK: Make constraints
private extension MeditationAudioView {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            backButton.widthAnchor.constraint(equalToConstant: 24.scale),
            backButton.heightAnchor.constraint(equalToConstant: 24.scale),
            backButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8.scale),
            backButton.topAnchor.constraint(equalTo: topAnchor, constant: ScreenSize.isIphoneXFamily ? 64.scale : 30.scale)
        ])
        
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 343.scale),
            imageView.heightAnchor.constraint(equalToConstant: 271.scale),
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: ScreenSize.isIphoneXFamily ? 120.scale : 70.scale)
        ])
        
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16.scale),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16.scale),
            nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 32.scale)
        ])
        
        NSLayoutConstraint.activate([
            playPauseButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            playPauseButton.widthAnchor.constraint(equalToConstant: 109.scale),
            playPauseButton.heightAnchor.constraint(equalToConstant: 109.scale),
            playPauseButton.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 32.scale)
        ])
        
        NSLayoutConstraint.activate([
            playerBackButton.widthAnchor.constraint(equalToConstant: 39.scale),
            playerBackButton.heightAnchor.constraint(equalToConstant: 39.scale),
            playerBackButton.trailingAnchor.constraint(equalTo: playPauseButton.leadingAnchor, constant: -34.scale),
            playerBackButton.centerYAnchor.constraint(equalTo: playPauseButton.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            playerForwardButton.widthAnchor.constraint(equalToConstant: 39.scale),
            playerForwardButton.heightAnchor.constraint(equalToConstant: 39.scale),
            playerForwardButton.leadingAnchor.constraint(equalTo: playPauseButton.trailingAnchor, constant: 34.scale),
            playerForwardButton.centerYAnchor.constraint(equalTo: playPauseButton.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            slider.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20.scale),
            slider.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20.scale),
            slider.heightAnchor.constraint(equalToConstant: 17.scale),
            slider.topAnchor.constraint(equalTo: playPauseButton.bottomAnchor, constant: 34.scale)
        ])
        
        NSLayoutConstraint.activate([
            currentTimeLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20.scale),
            currentTimeLabel.topAnchor.constraint(equalTo: slider.bottomAnchor, constant: 8.scale)
        ])
        
        NSLayoutConstraint.activate([
            totalTimeLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20.scale),
            totalTimeLabel.topAnchor.constraint(equalTo: slider.bottomAnchor, constant: 8.scale)
        ])
    }
}

// MARK: Lazy initialization
private extension MeditationAudioView {
    func makeBackButton() -> UIButton {
        let view = UIButton()
        view.setImage(UIImage(named: "MeditationAudio.Back"), for: .normal)
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeImageView() -> UIImageView {
        let view = UIImageView()
        view.layer.cornerRadius = 10.scale
        view.clipsToBounds = true
        view.contentMode = .scaleAspectFill
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeLabel() -> UILabel {
        let view = UILabel()
        view.numberOfLines = 2
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makePlayPauseButton() -> PlayPauseButton {
        let view = PlayPauseButton()
        view.stateCode = .pause
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makePlayerBackButton() -> UIButton {
        let view = UIButton()
        view.setImage(UIImage(named: "MeditationAudio.Player.Back"), for: .normal)
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makePlayerForwardButton() -> UIButton {
        let view = UIButton()
        view.setImage(UIImage(named: "MeditationAudio.Player.Forward"), for: .normal)
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
    
    func makeSlider() -> UISlider {
        let view = UISlider()
        view.thumbTintColor = UIColor(integralRed: 132, green: 214, blue: 218)
        view.minimumTrackTintColor = UIColor(integralRed: 132, green: 214, blue: 218)
        view.maximumTrackTintColor = UIColor.white.withAlphaComponent(0.2)
        view.isContinuous = true
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
}
