//
//  Locality.swift
//  
//
//  Created by Junior Quevedo Gutiérrez  on 9/12/23.
//

import Foundation

public class Locality: NSObject, Codable {
    public let uid : String
    public let name : String
    public let area : String
    public var isSelect :  Bool = false

    public override var description: String {
        name
    }
    
    public init(uid: String, name: String, area: String) {
        self.uid = uid
        self.name = name
        self.area = area
    }
}
