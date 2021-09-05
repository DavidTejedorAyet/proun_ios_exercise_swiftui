//
//  Int+HttpStatus.swift
//  proun-ios-exercise-swiftui
//
//  Created by David on 5/9/21.
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
