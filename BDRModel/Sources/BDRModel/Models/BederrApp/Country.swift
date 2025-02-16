//
//  File.swift
//  
//
//  Created by Junior on 23/01/23.
//

import Foundation

// MARK: - Country
public struct Country {
    public init(uid: String, name: String, code: String, areas: [Area], deliveryServices: [DeliveryService]) {
        self.uid = uid
        self.name = name
        self.code = code
        self.areas = areas
        self.deliveryServices = deliveryServices
    }
    
    public let uid, name, code: String
    public let areas: [Area]
    public let deliveryServices: [DeliveryService]
}
