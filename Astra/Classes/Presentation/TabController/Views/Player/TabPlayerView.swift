//
//  TabPlayer.swift
//  Astra
//
//  Created by Andrey Chernyshev on 28.09.2021.
//

final class TabPlayerView: GradientView {
    lazy var imageView = makeImageView()
    lazy var label = makeLabel()
    lazy var playPauseButton = makePlayPauseView()
    
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
extension TabPlayerView {
    func fill(audio: MeditationAudio) {
        if let url = URL(string: audio.imageUrl) {
            imageView.kf.setImage(with: url)
        }
        
        label.attributedText = audio.title
            .attributed(with: TextAttributes()
                            .textColor(UIColor.white)
                            .font(Fonts.Qanelas.semiBold(size: 14.scale))
                            .lineHeight(19.6.scale))
    }
}

// MARK: Private
private extension TabPlayerView {
    func initialize() {
        gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
        gradientLayer.colors = [
            UIColor(integralRed: 128, green: 221, blue: 216).cgColor,
            UIColor(integralRed: 176, green: 160, blue: 233).cgColor
        ]
    }
}

// MARK: Make constraints
private extension TabPlayerView {
    func makeConstraints() {
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: 51.scale),
            imageView.heightAnchor.constraint(equalToConstant: 40.scale),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16.scale),
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            label.centerYAnchor.constraint(equalTo: centerYAnchor),
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 79.scale),
            label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -60.scale)
        ])
        
        NSLayoutConstraint.activate([
            playPauseButton.widthAnchor.constraint(equalToConstant: 40.scale),
            playPauseButton.heightAnchor.constraint(equalToConstant: 40.scale),
            playPauseButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            playPauseButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16.scale)
        ])
    }
}

// MARK: Lazy initialization
private extension TabPlayerView {
    func makeImageView() -> UIImageView {
        let view = UIImageView()
        view.layer.cornerRadius = 4.scale
        view.layer.masksToBounds = true
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
    
    func makePlayPauseView() -> TabPlayerPlayPauseView {
        let view = TabPlayerPlayPauseView()
        view.stateCode = .pause
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        return view
    }
}
