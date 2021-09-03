//
//  Double.swift
//  proun-ios-exercise-swiftui
//
//  Created by David on 2/9/21.
//

import Foundation

extension Double {
    static func randomScale() -> Double {
        return Double(arc4random()) / Double(UINT32_MAX) * 2.0 - 1.0
      }
}
