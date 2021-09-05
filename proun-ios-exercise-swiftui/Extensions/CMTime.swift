//
//  CMTime.swift
//  proun-ios-exercise-swiftui
//
//  Created by David on 5/9/21.
//

import Foundation
import AVFoundation

extension CMTime {
    var roundedSeconds: TimeInterval {
        if seconds.isNaN || seconds.isInfinite { return 0 }
        return seconds.rounded()
    }
    var hours:  Int { return Int(roundedSeconds / 3600) }
    var minute: Int { return Int(roundedSeconds.truncatingRemainder(dividingBy: 3600) / 60) }
    var second: Int { return Int(roundedSeconds.truncatingRemainder(dividingBy: 60)) }
    var positionalTime: String {
        return hours > 0 ?
            String(format: "%d:%02d:%02d",
                   hours, minute, second) :
            String(format: "%02d:%02d",
                   minute, second)
    }
}
