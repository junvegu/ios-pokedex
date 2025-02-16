//
//  NSLayoutConstraint.swift
//  
//
//  Created by Junior Quevedo Gutiérrez  on 9/08/24.
//

import Foundation
import UIKit

public extension NSLayoutConstraint {
    @discardableResult
    public func usingPriority(_ priority: UILayoutPriority) -> NSLayoutConstraint {
        self.priority = priority
        return self
    }

    @discardableResult
    public func withConstant(_ constant: CGFloat) -> NSLayoutConstraint {
        self.constant = constant
        return self
    }

    @discardableResult
    public func storing(in variable: inout NSLayoutConstraint?) -> NSLayoutConstraint {
        variable = self
        return self
    }

    @discardableResult
    public func activating() -> NSLayoutConstraint {
        isActive = true
        return self
    }
}
