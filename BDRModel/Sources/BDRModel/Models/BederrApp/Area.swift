//
//  Area.swift
//  
//
//  Created by Junior on 23/01/23.
//

import Foundation

// MARK: - Area
public class Area: NSObject, Codable {
    public init(uid: String, name: String) {
        self.uid = uid
        self.name = name
    }
    
    public let uid, name: String
    
    public override var description: String {
        name
    }
}

