//
//  File.swift
//  
//
//  Created by Junior on 18/09/22.
//

import Foundation
public enum TypeDocument: String, Codable {
    case nationalID = "NATIONAL_ID"
    case password = "PASSPORT"
    case taxID = "TAX_ID"
    case foreingID = "FOREIGNER_ID"
    case other = "OTHER"

    public var isUndocument: Bool {
        return self.rawValue == "UNDOCUMENTED"
    }
    
    public var name: String {
        switch self {
            
        case .nationalID:
            return "Documento Nacional de Identidad"
        case .password:
            return "Pasaporte"
        case .taxID:
            return "Carne de Extranjeria"
        case .foreingID:
            return "Carne de Extranjeria"
        case .other:
            return "Otro"
        }
    }
}
