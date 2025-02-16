//
//  Array + DecodableMapper.swift
//  
//
//  Created by Junior on 4/12/21.
//

import Foundation
extension Array: DecodableMapper where Element: DecodableMapper { }
