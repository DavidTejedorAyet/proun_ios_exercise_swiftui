//
//  AVPlayer.swift
//  proun-ios-exercise-swiftui
//
//  Created by David on 4/9/21.
//

import Foundation
import AVFoundation

extension AVPlayer {
    var isPlaying: Bool {
        return rate != 0 && error == nil
    }
}
