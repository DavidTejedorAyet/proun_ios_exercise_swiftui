//
//  AudioPlayerViewModel.swift
//  proun-ios-exercise-swiftui
//
//  Created by David on 4/9/21.
//

import Foundation
import AVFoundation
import SwiftUI

class AudioPlayerViewModel: ObservableObject {
    @Published var player : AVPlayer!
    @Published var isPlaying = false
    @Published var audio: MediaModel
    @Published var isFinished = false
    @Published var progressBarWidth: CGFloat = 0.0
    
    @Published var totalDuration: String = "00:00"
    @Published var currentTime: String = "00:00"

    init(audio: MediaModel) {
        self.audio = audio
    }
    
    func onTapPlayButton() {
        if player.isPlaying {
            player.pause()
            isPlaying = false
        } else{
            if isFinished {
                player.seek(to: CMTime(seconds: 0, preferredTimescale: .max))
                progressBarWidth = 0
                isFinished = false
            }
            player.play()
            isPlaying = true
        }
    }
    
    func changeProgressBarValue(value: CGFloat) {
        let x = value
        progressBarWidth = x
        player.pause()
    }
    
    func onEndProgressBarChange(value: CGFloat, progressBarWidth: CGFloat) {
        let x = value
        let percent = x / progressBarWidth
        let time = Double(percent) * (player.currentItem?.duration.seconds ?? 0.0)
        
        player.seek(to: CMTime(seconds: time, preferredTimescale: .max))
        player.play()
        isFinished = false
    }
    
    func prepareAudio(barWidth: CGFloat) {
        let url = URL(string: audio.url ?? "")
        let playerItem = AVPlayerItem(url: url!)
        player = AVPlayer(playerItem: playerItem)
        NotificationCenter.default.addObserver(self, selector: #selector(playerDidFinishPlaying), name: .AVPlayerItemDidPlayToEndTime, object: nil)
    
        guard let playerItem = player.currentItem else { return }
        
        totalDuration = playerItem.duration.positionalTime
        
        Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true) { (_) in
            if self.player.isPlaying{
                let value = playerItem.currentTime().seconds / playerItem.duration.seconds
                self.progressBarWidth = barWidth * CGFloat(value)
                self.currentTime = playerItem.currentTime().positionalTime

            }
        }
        
    }
    
    @objc func playerDidFinishPlaying(notification: Notification) {
        isFinished = true
    }
    
    
}
