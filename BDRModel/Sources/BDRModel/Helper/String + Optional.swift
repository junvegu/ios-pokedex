//
//  String + Optional.swift
//
//
//  Created by Junior Quevedo Gutiérrez  on 9/12/23.
//

import Foundation
public extension Optional where Wrapped == String {

    var isEmptyOrNil: Bool {
        return self?.isEmpty ?? true
    }

}
