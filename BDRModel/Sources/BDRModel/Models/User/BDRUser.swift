////
////  User.swift
////
////
////  Created by Junior on 26/10/22.
////
//
public protocol User {
    var firstName: String { get set }
    var lastName: String { get set }
    var email: String? { get set }
    var documentNumber: String? { get set }
    var documentType: TypeDocument? { get set }
    var gender: String { get set }
    var mobileNumber: String { get set }
    var birthdate: String { get set }
    var areaUid: String? { get set }
    var countryUid: String? { get set }
    var areaName: String? { get set }
    var countryName: String? { get set }
    var points: Int? { get set }
    var acceptedTermsCond: Bool { get set }
    var levels: [Level] { get set }
    var verifiedEmail: Bool { get set }
    var verifiedMobileNumber: Bool { get set }
    var area: Area?  { get set }
    var locality: Locality? { get set }
    var countryCode: String? { get set }
    var postalCode: String? { get set }
    
}

public extension User {
    var fullname: String {
        return firstName + " " + lastName
    }
    
    var mobileInternationalNumber: String {
        return "+" + (countryCode ?? "" ) + mobileNumber
    }
}

public struct Level: Codable {
    
    public let uid: String
    public let name: String
    public let descriptionLevel: String?
    public let totalBadges: Int?
    public let pointsRequired: Int?
    public let maxPoints: Int?
    public let position: Int?
    public let active: Bool
    public let image: String?
    public let color: String?
    
    public init(uid: String, name: String, descriptionLevel: String?,
                totalBadges: Int?, pointsRequired: Int?, maxPoints: Int?,
                position: Int?, active: Bool, image: String?, color: String?) {
        self.uid = uid
        self.name = name
        self.descriptionLevel = descriptionLevel
        self.totalBadges = totalBadges
        self.pointsRequired = pointsRequired
        self.maxPoints = maxPoints
        self.position = position
        self.active = active
        self.image = image
        self.color = color
    }
    
}


