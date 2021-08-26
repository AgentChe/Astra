//
//  AudioPlayer.swift
//  Astra
//
//  Created by Andrey Chernyshev on 26.08.2021.
//

import UIKit
import AVFoundation

final class AudioPlayer: NSObject {
    weak var delegate: AudioPlayerDelegate? {
        didSet {
            let duration = item.asset.duration
            let totalSeconds = CMTimeGetSeconds(duration)
            
            let currentSeconds = CMTimeGetSeconds(player.currentTime())
            
            delegate?.audioPlayer(totalDuration: totalSeconds)
            delegate?.audioPlayer(currentTime: currentSeconds)
        }
    }
    
    private let audio: MeditationAudio
    private let url: URL
    
    private lazy var item = AVPlayerItem(url: url)
    private lazy var player = AVPlayer(playerItem: item)
    
    private var playerTimeObserver: Any?
    
    init?(audio: MeditationAudio) {
        self.audio = audio
        
        guard let url = URL(string: audio.audioUrl) else {
            return nil
        }
        
        self.url = url
        
        super.init()
        
        NotificationCenter.default
            .addObserver(self,
                         selector: #selector(didFinished),
                         name: NSNotification.Name.AVPlayerItemDidPlayToEndTime,
                         object: item)
        
        playerTimeObserver = player.addPeriodicTimeObserver(forInterval: CMTimeMakeWithSeconds(1, preferredTimescale: 1), queue: DispatchQueue.main) { [weak self] time in
            guard let self = self else {
                return
            }
            
            guard self.item.status == .readyToPlay else {
                return
            }
            
            let currentSeconds = CMTimeGetSeconds(self.player.currentTime())
            
            self.delegate?.audioPlayer(currentTime: currentSeconds)
        }
    }
}

// MARK: Public
extension AudioPlayer {
    func play() {
        player.play()
    }
    
    func pause() {
        player.pause()
    }
    
    func back() {
        player.pause()
        
        let currentSeconds = CMTimeGetSeconds(player.currentTime())
        
        var newTime = currentSeconds - 15
        
        if newTime < 0 {
            newTime = 0
        }
        
        let selectedTime = CMTimeMake(value: Int64(newTime * 1000 as Float64), timescale: 1000)
        
        player.seek(to: selectedTime) { [weak self] success in
            self?.player.play()
        }
    }
    
    func forward() {
        player.pause()
        
        let duration = item.asset.duration
        let totalSeconds = CMTimeGetSeconds(duration)
        
        let currentSeconds = CMTimeGetSeconds(player.currentTime())
        
        var newTime = currentSeconds + 15
        
        if newTime > totalSeconds {
            newTime = totalSeconds
        }
        
        let selectedTime = CMTimeMake(value: Int64(newTime * 1000 as Float64), timescale: 1000)
        
        player.seek(to: selectedTime) { [weak self] success in
            self?.player.play()
        }
    }
    
    func seek(to value: Float) {
        let seconds = TimeInterval(value)
        let targetTime = CMTime(seconds: seconds, preferredTimescale: 1)
        
        player.seek(to: targetTime) { [weak self] success in
            self?.player.play()
        }
    }
    
    @objc
    func didFinished() {
        player.pause()
        
        delegate?.audioPlayerFinished()
    }
    
    func clear() {
        player.pause()
        
        if let observer = playerTimeObserver {
            player.removeTimeObserver(observer)
        }
        
        NotificationCenter.default.removeObserver(self)
    }
}
