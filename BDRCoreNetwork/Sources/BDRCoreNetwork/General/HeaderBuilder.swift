//
//  File.swift
//  
//
//  Created by Junior on 5/12/21.
//

import Foundation
import Alamofire

public class HeaderBuilder {
    public static func build() -> HTTPHeaders  {
        var headers: HTTPHeaders = [BDRCoreNetworkConstants.HTTPHeaders.accept.rawValue: "application/json",
                BDRCoreNetworkConstants.HTTPHeaders.contentType.rawValue: "application/json",
                BDRCoreNetworkConstants.HTTPHeaders.acceptLanguage.rawValue: "es-US,es;q=0.9,es-419;q=0.8,en;q=0.7"]
        
     //   if let token = TokenManager.shared.fetchAccessToken() {
          //  headers.add(name: BDRCoreNetworkConstants.HTTPHeaders.authorization.rawValue, value: "Token " + token)
      //  }
    
        return headers
    }
}
