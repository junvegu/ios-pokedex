//
//  ValidationError.swift
//  
//
//  Created by Junior on 6/03/23.
//

import Foundation

public enum TypeEditionComponent {
    case readOnly
    case optional
    case requiered
}

public enum ValidationError: Error {
    case custom(message: String)
}

public protocol ValidationManager {
    func validate(_ val: String?) throws
}

public struct NullOrEmptyValidation: ValidationManager {
    public init() { }
    public func validate(_ val: String?) throws {
        guard let val = val, !val.isEmpty else {
            throw ValidationError.custom(message: "Este campo no puede estar vacio")
        }
    }
}

public struct EmailValidation: ValidationManager {
    public init() { }
    public func validate(_ val: String?) throws {
        guard let candidate = val, !candidate.isEmpty else {
            throw ValidationError.custom(message: "Este campo no puede estar vacio")
        }
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
        let result = NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: candidate)
        if !result {
            throw ValidationError.custom(message: "El correo electrónico no tiene un formato válido")
        }
    }
}

public struct PostalCodeValidation: ValidationManager {
    public init() { }
    public func validate(_ val: String?) throws {
        guard let candidate = val, !candidate.isEmpty else {
            throw ValidationError.custom(message: "Este campo no puede estar vacio")
        }
        let emailRegex = "^[0-9]{5}$"
        let result = NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: candidate)
        if !result {
            throw ValidationError.custom(message: "El código postal debe tener 5 dígitos númericos5")
        }
    }
}


public struct UpperCaseLetterValidation: ValidationManager {
    public init() { }
    public func validate(_ val: String?) throws {
        guard let candidate = val, !candidate.isEmpty else {
            throw ValidationError.custom(message: "Este campo no puede estar vacio")
        }
        let result = val?.rangeOfCharacter(from: .uppercaseLetters) != nil
        if !result {
            throw ValidationError.custom(message: "Debe contener al menos una mayúscula")
        }
    }
}

public struct MinPasswordTextValidation: ValidationManager {
    public init() { }
    public func validate(_ val: String?) throws {
        guard let val = val, val.count >= 8 else {
            throw ValidationError.custom(message: "Debe contener al menos 8 carácteres")
        }
    }
}

public struct LowerCaseLetterValidation: ValidationManager {
    public init() { }
    public func validate(_ val: String?) throws {
        guard let candidate = val, !candidate.isEmpty else {
            throw ValidationError.custom(message: "Este campo no puede estar vacio")
        }
        let result = val?.rangeOfCharacter(from: .lowercaseLetters) != nil
        if !result {
            throw ValidationError.custom(message: "Debe contener al menos una minúscula")
        }
    }
}


public struct NumberOnLetterValidation: ValidationManager {
    public init() { }
    public func validate(_ val: String?) throws {
        guard let candidate = val, !candidate.isEmpty else {
            throw ValidationError.custom(message: "Este campo no puede estar vacio")
        }
        let result = val?.rangeOfCharacter(from: .decimalDigits) != nil
        if !result {
            throw ValidationError.custom(message: "Debe contener al menos un número")
        }
    }
}

public struct SpecialCharacterValidation: ValidationManager {
    public init() { }
    public func validate(_ val: String?) throws {
        guard let candidate = val, !candidate.isEmpty else {
            throw ValidationError.custom(message: "Este campo no puede estar vacio")
        }
        
        let specialCharacterSet = CharacterSet(charactersIn: "!@#$%^&*()-_=+[{]}|;:'\",<.>/?")
        let result = val?.rangeOfCharacter(from: specialCharacterSet) != nil
        if !result {
            throw ValidationError.custom(message: "Debe contener al menos un carácter especial")
        }
    }
}


public struct TermsBooleanToogleValidation: ValidationManager {
    public init() { }
    public func validate(_ val: String?) throws {
        guard let val = val, Bool(val) ?? false else {
            throw ValidationError.custom(message: "Debe seleccionar los términos y condiciones")
        }
    }
}
