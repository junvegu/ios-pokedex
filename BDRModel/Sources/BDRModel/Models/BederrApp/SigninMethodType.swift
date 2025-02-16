//
//  File.swift
//  
//
//  Created by Junior on 23/01/23.
//

import Foundation

// MARK: - SigninMethod
public enum SigninMethodType: String {
    case document = "ONLY_DOCUMENT"
    case documentPassword = "DOCUMENT"
    case email = "EMAIL"
    case phone = "MOBILE_NUMBER"

    var description: String {
        switch self {
        case .document:
            return "Ingresa con documento"
        case .documentPassword:
            return "Ingresa con documento."
        case .email:
            return "Ingresa con email"
        case .phone:
            return "Ingresa con teléfono"
        }
    }
    
}

public class SigninMethodTypeForPicker: NSObject {
    public let type: SigninMethodType
    init(type: SigninMethodType) {
        self.type = type
    }
    public override var description: String {
        return type.description
    }
    
    public class func mapFromSigningCases(_ types: [SigninMethodType]) -> [SigninMethodTypeForPicker] {
        types.map { item in
            SigninMethodTypeForPicker(type: item)
        }
    }
}
