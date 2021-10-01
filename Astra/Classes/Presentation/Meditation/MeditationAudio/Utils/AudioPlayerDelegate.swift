//
//  AudioPlayerDelegate.swift
//  Astra
//
//  Created by Andrey Chernyshev on 26.08.2021.
//

protocol AudioPlayerDelegate: AnyObject {
    func audioPlayer(totalDuration: Float64)
    func audioPlayer(currentTime: Float64)
    func audioPlayerFinished()
    func audioPlayerDidStartPlay()
}
