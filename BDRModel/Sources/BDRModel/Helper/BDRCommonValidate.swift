//
//  BDRCommonValidate.swift
//  
//
//  Created by Junior on 18/09/22.
//

import Foundation
public enum ValidationType {
    case email
    case stringWithFirstLetterCaps
    case alphabeticString
    case password
    case securePassword
    case min6Lenght
    
    var regex: String {
        switch self {
        case .email:
            return "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}" // Email
        case .stringWithFirstLetterCaps:
            return "^[A-Z]+[a-zäáàëéèíìöóòúùñçA-ZÑÁÉÍÓÚÇ]*$"
        case .password, .securePassword:
            ///Minimum 8 characters at least 1 Uppercase Alphabet, 1 Lowercase Alphabet, 1 Number and 1 Special Character:
            return "^(?=.*[A-Za-z])(?=.*\\d)(?=.*[$@$!%*#?&])[A-Za-z\\d$@.$!%*#?&]{8,}$"
        case .alphabeticString:
            return "^[a-zäáàëéèíìöóòúùñçA-ZÑÁÉÍÓÚÇ ]*$"
        case .min6Lenght:
            return "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d^a-zA-Z0-9].{6,20}$"
        }
    }
        
    public func validate(_ input: String?) -> Bool {
        return BDRCommonValidate.isValid(input, regex: self.regex)
    }
}
public struct BDRCommonValidate {
    // MARK: - Validations Regex
    public static func isValid(_ input: String?, regex: String) -> Bool {
        return NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: input)
    }
    
    public static func isValid(_ input: String?, regex: ValidationType) -> Bool {
        return NSPredicate(format: "SELF MATCHES %@", regex.regex).evaluate(with: input)
    }
}
import Foundation

public typealias BDRCompletionFlowBlock = () -> Void
