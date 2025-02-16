//
//  NetworkLogger.swift
//  
//
//  Created by Junior on 5/12/21.
//

import Foundation
import Alamofire

class BDRNetworkLogger: EventMonitor {
    let queue = DispatchQueue(label: "com.bederrr.networklogger")
    
    func requestDidFinish(_ request: Request) {
        print("URL REQUEST: ---> " + request.description)
      
    }
    
    func request<Value>(_ request: DataRequest, didParseResponse response: DataResponse<Value, AFError>) {
        guard let data = response.data else {
            return
        }
        if let headers = request.request?.headers {
            print("HTTP-HEADERS: ---> \(headers.dictionary.debugDescription)")
        }
        if let dataBody = response.request?.httpBody,
           let encodingDataDescription =  NSString(data: dataBody, encoding: String.Encoding.utf8.rawValue){
            print("HTTP-BODY: ---> \(encodingDataDescription)")
        }
        
        if let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) {
            print("HTTP-RESPONSE: --->\n \(json)")
        }
    }
}
