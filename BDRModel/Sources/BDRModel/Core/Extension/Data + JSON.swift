//
//  Data + JSON.swift
//  
//
//  Created by Junior on 4/12/21.
//

import Foundation

public extension Data {
    
    init(nameJson: String, bundle: Bundle = Bundle.main) {
        do {
            if let file = bundle.url(forResource: nameJson, withExtension: "json") {
                try self.init(contentsOf: file)
                return
            }
        }catch {
            print(error.localizedDescription)
        }
        self.init()
    }
    
}
