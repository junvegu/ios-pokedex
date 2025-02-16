//
//  InnerProducts.swift
//  
//
//  Created by Junior on 23/01/23.
//

import Foundation
// MARK: - DeliveryService
public struct InnerProducts {
    public init(uid: String, name: String, code: String, image: URL) {
        self.uid = uid
        self.name = name
        self.code = code
        self.image = image
    }
    
    public let uid, name, code: String
    public let image: URL
}
