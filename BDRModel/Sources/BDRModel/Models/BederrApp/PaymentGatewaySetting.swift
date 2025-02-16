//
//  File.swift
//  
//
//  Created by Junior on 23/01/23.
//

import Foundation

// MARK: - PaymentGatewaySettings
public struct PaymentGatewaySettings {
    public init(paymentGateway: String, publicKey: String) {
        self.paymentGateway = paymentGateway
        self.publicKey = publicKey
    }
    
    public let paymentGateway, publicKey: String
}
