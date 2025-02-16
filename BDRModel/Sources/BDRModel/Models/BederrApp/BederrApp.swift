//
//  BederrApp.swift
//  
//
//  Created by Junior on 24/07/22.
//

import Foundation

// MARK: - Welcome
public class BederrApp: NSObject {
    public let uid: String
    public let name: String
    public let apiKey: String
    public let iosVersion: String
    public let company: Company
    public let signinMethods: [SigninMethodType]
    public let allowedCompanies: [Company]
    public let allowedPrograms: [AllowedProgram]
    public let countries: [Country]
    public let verifyEmail, verifyDocument, verifyMobileNumber: Bool
    public let requirePasswordToUsersWithLoginOnlyDocument: Bool
    public let site: Site
    public let requirePin: Bool
    public let defaultArea: Area
    
    public init(uid: String, name: String, apiKey: String,
                iosVersion: String, company: Company,
                signinMethods: [SigninMethodType],
                allowedCompanies: [Company],
                allowedPrograms: [AllowedProgram],
                countries: [Country],
                verifyEmail: Bool, verifyDocument: Bool, verifyMobileNumber: Bool,
                site: Site,
                requirePin: Bool,
                defaultArea: Area,
                requirePasswordToUsersWithLoginOnlyDocument: Bool) {
        self.uid = uid
        self.name = name
        self.apiKey = apiKey
        self.iosVersion = iosVersion
        self.company = company
        self.signinMethods = signinMethods
        self.allowedCompanies = allowedCompanies
        self.allowedPrograms = allowedPrograms
        self.countries = countries
        self.verifyEmail = verifyEmail
        self.verifyDocument = verifyDocument
        self.verifyMobileNumber = verifyMobileNumber
        self.site = site
        self.requirePin = requirePin
        self.defaultArea = defaultArea
        self.requirePasswordToUsersWithLoginOnlyDocument = requirePasswordToUsersWithLoginOnlyDocument
    }
    

}
