//
//  File.swift
//  
//
//  Created by Junior on 23/01/23.
//

import Foundation

// MARK: - DeliveryService
public struct DeliveryService {
    public init(uid: String, name: String, code: String) {
        self.uid = uid
        self.name = name
        self.code = code
    }
    
    public let uid, name, code: String
}
