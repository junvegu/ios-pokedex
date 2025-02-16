//
//  File.swift
//  
//
//  Created by Junior on 4/12/21.
//

import Foundation

public extension String {
    static func json(withFile: String, bundle: Bundle) -> String {
        let data = Data(nameJson: withFile, bundle: bundle)
        return String(decoding: data, as: UTF8.self)
    }
}
