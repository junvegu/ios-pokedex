//
//  PaymentMethod.swift
//
//
//  Created by Junior Quevedo Gutiérrez  on 12/02/24.
//

import Foundation

public struct PaymentMethod {
    public let uid: String
    public let name: String
    public let type: String
    public let descriptionPayment: String
    public var select: Bool = false
    
    public init(uid: String, name: String, type: String, descriptionPayment: String, select: Bool) {
        self.uid = uid
        self.name = name
        self.type = type
        self.descriptionPayment = descriptionPayment
        self.select = select
    }
}
