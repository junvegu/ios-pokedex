//
//  DeliveryMethod.swift
//
//
//  Created by Junior Quevedo Gutiérrez  on 12/02/24.
//

import Foundation

public struct DeliveryMethod {
    public let uid: String
    public let name: String
    public let type: String
    public let descriptionDelivery: String
    public var select: Bool = false 
    public init(uid: String, name: String, type: String, descriptionDelivery: String, select: Bool) {
        self.uid = uid
        self.name = name
        self.type = type
        self.descriptionDelivery = descriptionDelivery
        self.select = select
    }
}
