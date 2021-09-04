//
//  UIImage.swift
//  proun-ios-exercise-swiftui
//
//  Created by David on 3/9/21.
//

import Foundation
import UIKit
import SwiftUI

extension UIImage {
    
    convenience init?(withContentsOfUrl stringUrl: String) {
        do {
            let url = URL(string: stringUrl)!
            let imageData = try Data(contentsOf: url)
            self.init(data: imageData)
        } catch {
            self.init(data: Data())
        }
        
    }
    
}
