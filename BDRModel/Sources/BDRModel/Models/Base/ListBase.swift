//
//  ListBase.swift
//  
//
//  Created by Junior on 4/12/21.
//

import Foundation

public struct ListBase<T: DecodableMapper>: DecodableMapper {
    public let count: Int
    public let next: String?
    public let previous: String?
    public let results: [T]
}
