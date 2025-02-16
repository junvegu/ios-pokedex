//
//  Place.swift
//
//
//  Created by Junior Quevedo Gutiérrez  on 12/02/24.
//

import Foundation
import CoreLocation
public protocol PlaceCompany {
    var uid : String { get set }
    var name : String { get set }
    var address: String { get set }
    var whatsappNumber : String { get set }
    var location: CLLocationCoordinate2D { get set }
    var telephone1 : String { get set }
    var telephone2 : String { get set }
    var contactEmail : String { get set }
    var timeTable : TimeTable { get set }
}

public struct Place: PlaceCompany {
    public var timeTable: TimeTable
    public var uid : String
    public var name : String
    public var address: String
    public var whatsappNumber : String
    public var location: CLLocationCoordinate2D
    public var telephone1 : String
    public var telephone2 : String
    public var contactEmail : String
    
    public let paymentMethods: [PaymentMethod]
    public let deliveryMethods: [DeliveryMethod]
    public let deliveryZone: [DeliveryLocality]
    public let locality : Locality
    public let cover : String
    public let featured : Bool
    public let reservationPhone : String
    public let timetable : TimeTable
    public let ecommerceEnabled : Bool
    public let delivery : String
    public let price : String
    public let isDigitalEntity : Bool
    public let usesCountryDeliveryService : Bool
    
    public init(uid: String,
                name: String,
                address: String,
                paymentMethods: [PaymentMethod],
                deliveryMethods: [DeliveryMethod],
                deliveryZone: [DeliveryLocality],
                location: CLLocationCoordinate2D,
                telephone1: String,
                telephone2: String,
                locality: Locality,
                cover: String,
                featured: Bool,
                reservationPhone: String,
                contactEmail: String,
                timetable: TimeTable,
                ecommerceEnabled: Bool,
                delivery: String,
                price: String,
                whatsappNumber: String,
                isDigitalEntity: Bool,
                usesCountryDeliveryService: Bool,
                timeTable: TimeTable) {
        self.uid = uid
        self.name = name
        self.address = address
        self.paymentMethods = paymentMethods
        self.deliveryMethods = deliveryMethods
        self.location = location
        self.telephone1 = telephone1
        self.telephone2 = telephone2
        self.locality = locality
        self.cover = cover
        self.featured = featured
        self.reservationPhone = reservationPhone
        self.contactEmail = contactEmail
        self.timetable = timetable
        self.ecommerceEnabled = ecommerceEnabled
        self.delivery = delivery
        self.price = price
        self.whatsappNumber = whatsappNumber
        self.isDigitalEntity = isDigitalEntity
        self.usesCountryDeliveryService = usesCountryDeliveryService
        self.deliveryZone = deliveryZone
        self.timeTable = timeTable
    }
}
