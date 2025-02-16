//
//  File.swift
//  
//
//  Created by Junior on 23/01/23.
//

import Foundation
// MARK: - Company
public struct Company {
    public init(uid: String, name: String, companyDescription: String, logo: URL, logoRectangle: URL, cover: URL, banner: URL, ecommerceEnabled: Bool, benefitProgramsEnabled: Bool, currency: Currency, paymentGatewaySettings: PaymentGatewaySettings, subscriptionEnabled: Bool, isDigitalEntity: Bool, facebookPage: String, instagramPage: String, whatsappNumber: String, deliveryService: DeliveryService, gamificationSystem: Bool, gamificationRules: [GamificationRule], type: String, innerProducts: [InnerProducts]) {
        self.uid = uid
        self.name = name
        self.companyDescription = companyDescription
        self.logo = logo
        self.logoRectangle = logoRectangle
        self.cover = cover
        self.banner = banner
        self.ecommerceEnabled = ecommerceEnabled
        self.benefitProgramsEnabled = benefitProgramsEnabled
        self.currency = currency
        self.paymentGatewaySettings = paymentGatewaySettings
        self.subscriptionEnabled = subscriptionEnabled
        self.isDigitalEntity = isDigitalEntity
        self.facebookPage = facebookPage
        self.instagramPage = instagramPage
        self.whatsappNumber = whatsappNumber
        self.deliveryService = deliveryService
        self.gamificationSystem = gamificationSystem
        self.gamificationRules = gamificationRules
        self.type = type
        self.innerProducts = innerProducts
    }
    
    public let uid, name, companyDescription: String
    public let logo: URL
    public let logoRectangle: URL
    public let cover: URL
    public let banner: URL
    public let ecommerceEnabled, benefitProgramsEnabled: Bool
    public let currency: Currency
    public let paymentGatewaySettings: PaymentGatewaySettings
    public let subscriptionEnabled, isDigitalEntity: Bool
    public let facebookPage, instagramPage: String
    public let whatsappNumber: String
    public let deliveryService: DeliveryService
    public let gamificationSystem: Bool
    public let gamificationRules: [GamificationRule]
    public let type: String
    public let innerProducts: [InnerProducts]
}
