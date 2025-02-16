//
//  File.swift
//  
//
//  Created by Junior on 30/10/22.
//

import Foundation
public struct BDRError: Error, Decodable {
    public let hasValidMember: Bool?
    public let nonFieldErrors: [String]?
    public let detail: String?
    public let email: [String]?
    public let mobileNumber: [String]?
    public let member: [String]?
    public let quantity: [String]?

    public var descriptionError: String {
        if let safeDetail = detail {
            return safeDetail
        }
        if let nonFieldErrors = nonFieldErrors {
            return nonFieldErrors.joined(separator: "\n")
        }
        
        if let emailErrors = email {
            return emailErrors.joined(separator: "\n")
        }
        if let mobileNumberErrors = mobileNumber {
            return mobileNumberErrors.joined(separator: "\n")
        }
        if let memberErrors = member {
            return memberErrors.joined(separator: "\n")
        }
        if let quantityErrors = quantity {
            return quantityErrors.joined(separator: "\n")
        }
        return "Error desconocido"
    }
    
    
    public init(hasValidMember: Bool? = false,
                nonFieldErrors: [String]? = nil,
                email: [String]? = nil,
                detail: String?,
                mobileNumber: [String]? = nil,
                member: [String]? = nil,
                quantity: [String]? = nil) {
        self.hasValidMember = hasValidMember
        self.nonFieldErrors = nonFieldErrors
        self.email = email
        self.detail = detail
        self.mobileNumber = mobileNumber
        self.member = member
        self.quantity = quantity
    }
    
    enum CodingKeys: String, CodingKey {
        case hasValidMember = "has_valid_member"
        case nonFieldErrors = "non_field_errors"
        case email = "email"
        case detail = "detail"
        case mobileNumber = "mobile_number"
        case member = "member"
        case quantity = "quantity"
    }
}
