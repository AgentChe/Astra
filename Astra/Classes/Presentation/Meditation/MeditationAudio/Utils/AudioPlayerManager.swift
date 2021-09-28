//
//  AudioPlayerManager.swift
//  Astra
//
//  Created by Andrey Chernyshev on 28.09.2021.
//

final class AudioPlayerManager {
    static let shared = AudioPlayerManager()
    
    private(set) var player: AudioPlayer?
    
    private init() {}
}

// MARK: Public
extension AudioPlayerManager {
    func makePlayerIfNeeded(audio: MeditationAudio) -> AudioPlayer? {
        guard player?.audio.id == audio.id else {
            player = AudioPlayer(audio: audio)
            return player
        }
        
        if let player = player {
            return player
        }
        
        player = AudioPlayer(audio: audio)
        
        return player
    }
}
