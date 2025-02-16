//
//  File.swift
//  
//
//  Created by Junior on 23/01/23.
//

import Foundation

// MARK: - Site
public struct Site {
    public init(name: String, termsAndConditions: String, privacyPolicies: String, dataTreatment: String) {
        self.name = name
        self.termsAndConditions = termsAndConditions
        self.privacyPolicies = privacyPolicies
        self.dataTreatment = dataTreatment
    }
    
    public let name : String
    public let termsAndConditions, privacyPolicies, dataTreatment: String
}
