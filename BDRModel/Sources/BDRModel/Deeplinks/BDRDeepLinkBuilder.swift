//
//  BDRDeepLinkBuilder.swift
//  
//
//  Created by Junior on 17/11/22.
//

import Foundation

public class BDRDeepLinkBuilder {
    public typealias DeepLinkPath = URL
    private var urlToRequest = BDRDeepLinkRouter.urlScheme
    private var queryItems: [URLQueryItem] = []
    public init() {}
    @discardableResult
    public func appendEndpoint(path: String) -> BDRDeepLinkBuilder {
        urlToRequest.append(path)
        return self
    }
    @discardableResult
    public func addParameters(key: String, value: String) -> BDRDeepLinkBuilder {
        queryItems.append(URLQueryItem(name: key, value: value))
        return self
    }
    
    public func build() -> DeepLinkPath? {
        guard var urlComps = URLComponents(string: urlToRequest) else {
            print("Invalid URL, check possibles whitespaces  and invalid characteres")
            return nil
        }
        urlComps.queryItems = queryItems
        return urlComps.url
    }
}
