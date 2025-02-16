//
//  File.swift
//  
//
//  Created by Junior Quevedo Gutiérrez  on 10/12/23.
//

import Foundation
public class BDRGender : NSObject{
    public var name : String = ""
    public var type : String = ""
    
    public override var description: String {
        return name
    }
    
    init(_ name : String, _ serverType : String) {
        super.init()
        self.name = name
        self.type = serverType
    }
    
    public class func retrieveData()-> [BDRGender] {
        return [BDRGender("Hombre","m"),
                BDRGender("Mujer","f")]
    }
}
