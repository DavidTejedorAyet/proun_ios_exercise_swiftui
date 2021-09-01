//
//  Constants.swift
//  Temp
//
//  Created by Miguel Estévez on 08/11/2018.
//  Copyright © 2018 Vanadis. All rights reserved.
//

import Foundation
import UIKit

enum Constants {
    
    static let bundle: Bundle = Bundle.main
    static let appName = bundle.infoDictionary![kCFBundleNameKey as String] as! String
    static let baseUrlString = "https://cityme-services.prepro.site/app_dev.php/api/"
}
