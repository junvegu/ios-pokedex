//
//  File.swift
//  
//
//  Created by Junior on 5/12/21.
//

import Foundation
import Alamofire

class BDRNetworkInterceptor: RequestInterceptor {
    let retryLimit = 5
    let retryDelay: TimeInterval = 10
    
//    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
//        var urlRequest = urlRequest
//       let headers = HeaderBuilder.build()
//      for header in headers {
//          urlRequest.setValue(header.value, forHTTPHeaderField: header.name)
//        }
//        completion(.success(urlRequest))
//    }
    
    func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        let response = request.task?.response as? HTTPURLResponse
        //Retry for 5xx status codes
        if let statusCode = response?.statusCode,
           (500...599).contains(statusCode),
           request.retryCount < retryLimit {
            completion(.retryWithDelay(retryDelay))
        } else if let statusCode = response?.statusCode, statusCode == 401{
            completion(.doNotRetry)
        } else {
            return completion(.doNotRetry)
        }
    }
}
