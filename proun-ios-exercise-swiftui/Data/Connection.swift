//
//  File.swift
//  BdeoSDK
//
//  Created by Miguel Estévez on 23/05/2019.
//  Copyright © 2019 Miguel Estévez. All rights reserved.
//

import Foundation

internal protocol ConnectionManager {
    func get(endpoint: String, params: [String: Any]?, completion: @escaping ConnectionCompletion)
}

typealias ConnectionCompletion = (_ httpStatus: Int, _ response: Any?) -> Void

internal class Connection: ConnectionManager {
    let baseUrlString = Constants.baseUrlString
    let configuration = URLSessionConfiguration.default
    
    enum HTTPMethod: String {
        case get = "GET"
    }
    
    internal func connect(to url: URL?, method: HTTPMethod, params: [String: Any]?, completion: @escaping ConnectionCompletion) -> Void {
        guard let url = url else {
            completion(400, nil)
            return
        }
        guard let data = try? JSONSerialization.data(withJSONObject: params ?? ["":""], options: .prettyPrinted) else {
            completion(400, nil)
            return
        }
        let defaultSessionConfiguration = URLSessionConfiguration.default
        
        let headers = ["Content-Type": "application/json",
                       "Accept" : "application/json"]
        
        defaultSessionConfiguration.httpAdditionalHeaders = headers
        let defaultSession = URLSession(configuration: defaultSessionConfiguration)
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        
        if method != .get {
            urlRequest.httpBody = data
        }
        
        let dataTask = defaultSession.dataTask(with: urlRequest) {
            (data, response, error) in
            
            var httpStatus = 0
            if let urlResponse = response as? HTTPURLResponse {
                httpStatus = urlResponse.statusCode
            }
            completion(httpStatus, data)
        }
        dataTask.resume()
    }
    
    private func url(for endpoint: String) -> URL? {
        return URL(string: Constants.baseUrlString + endpoint)
    }
    
    func get(endpoint: String, params: [String: Any]?, completion: @escaping ConnectionCompletion) {
        connect(to: url(for: endpoint), method: .get, params: params, completion: completion)
    }

    
}

internal func errorWith(code: Int, message: String) -> Error {
    return NSError(domain: Constants.appName, code: code, userInfo: [NSLocalizedDescriptionKey: message])
}

internal func errorMessageWith(_ response: Any?, httpStatus: Int) -> String {
    let message = "Something was wrong... httpStatus is \(httpStatus)"
    print(message)
    return message
}
