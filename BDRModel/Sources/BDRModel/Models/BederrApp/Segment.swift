//
//  File.swift
//  
//
//  Created by Junior on 23/01/23.
//

import Foundation
// MARK: - AllowedProgram
public struct Segment: Decodable {
    public init(uid: String, name: String, showMenuDealers: Bool, showMenuFFVV: Bool, showGamificationInfo: Bool) {
        self.uid = uid
        self.name = name
        self.showMenuDealers = showMenuDealers
        self.showMenuFFVV = showMenuFFVV
        self.showGamificationInfo = showGamificationInfo
    }
    
    public let uid, name: String
    public let showMenuDealers, showMenuFFVV, showGamificationInfo: Bool
}
