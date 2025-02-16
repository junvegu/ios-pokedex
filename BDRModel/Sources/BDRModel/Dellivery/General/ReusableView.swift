//
//  File.swift
//  
//
//  Created by Junior on 24/01/23.
//

import Foundation
import UIKit

public protocol ReusableView: AnyObject {
    static var identifier: String { get }
}
extension ReusableView {
    public static var identifier: String {
        return String(describing: self)
    }
}
