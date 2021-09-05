//
//  Constants.swift
//  proun-ios-exercise-swiftui
//
//  Created by David on 5/9/21.
//

import Foundation
import UIKit

enum Constants {
    
    static let bundle: Bundle = Bundle.main
    static let appName = bundle.infoDictionary![kCFBundleNameKey as String] as! String
    static let baseUrlString = "https://cityme-services.prepro.site/app_dev.php/api/"
}
