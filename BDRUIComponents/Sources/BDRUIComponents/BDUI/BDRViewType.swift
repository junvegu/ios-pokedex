//
//  File.swift
//  
//
//  Created by Junior on 14/09/22.
//

import Foundation
internal enum BDRUIFormValidation {
    case regex(String)
    case email
    case plainText
    case password
    case multiline
    case personName
    case postalCode
}

internal enum BDRUIFormViewType {
    case textField([BDRUIFormValidation])
    case phoneField
    case genderPicker
    case birthDatePicker
    case customDropDownPicker([NSObject])
}
