//
//  Int+HttpStatus.swift
//  BdeoSDK
//
//  Created by Miguel Estévez on 31/05/2019.
//  Copyright © 2019 Miguel Estévez. All rights reserved.
//

import Foundation

enum HttpStatus: Int {
    case ok, serverError, unauthorized, notFound, error
}

extension Int {
    var isOk : Bool {
        return self >= 200 && self < 300
    }
    
    var status : HttpStatus {
        switch self {
        case 200..<300: return .ok
        case 401: return .unauthorized
        case 404: return .notFound
        case 500..<600: return .serverError
        default:
            return .error
        }
    }
}
