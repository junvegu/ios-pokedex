//
//  BDRCustomControl.swift
//  
//
//  Created by Junior on 14/09/22.
//

import Foundation
import UIKit
open class BDRCustomControl: UIView {
    public var contentView: UIView!

    public func loadViewFromNib() {
        contentView = loadNib()
        contentView.frame = bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(contentView)
    }
}
