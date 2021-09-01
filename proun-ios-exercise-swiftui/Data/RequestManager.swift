

import Foundation

public enum Response <T: Any> {
    case success(T)
    case error(Error)
}


internal class RequestManager {
    
    let connection: ConnectionManager = Connection()
    
    internal func getDistrictPOIs(completion: @escaping (Response <DistrictPOIsResponse>) -> Void) {
        
        connection.get(endpoint: "districts/2", params: nil) {
            httpStatus, response in
            
            DispatchQueue.main.async {
                guard httpStatus.isOk, let data = response as? Data else {
                    let message = errorMessageWith(response, httpStatus: httpStatus)
                    completion(.error(errorWith(code: httpStatus, message: message)))
                    return
                }
                
                guard let response = DistrictPOIsResponse(jsonData: data) else {
                    let error = errorWith(code: -101, message: "Could not parse response into a valid model")
                    completion(.error(error))
                    return
                }
                completion(.success(response))
            }
        }
    }
    
    
}
