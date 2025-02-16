//
//  BDRUIComponents + UIColor.swift
//  
//
//  Created by Junior on 24/07/22.
//

import Foundation
import UIKit
import BDRModel

public extension UIColor {
    
    static let primary = BDRUIComponents.sharedInstance.config.primaryColor
    static let button = BDRUIComponents.sharedInstance.config.buttonColor
    static let disabledButton = BDRUIComponents.sharedInstance.config.disabledButtonColor
    static let secondary = BDRUIComponents.sharedInstance.config.secondaryColor
    static let accent = BDRUIComponents.sharedInstance.config.accentColor
    static let selectedAccent = UIColor.loadFromAssets("blue_selected")

    static let disclaimerColor =  UIColor.loadFromAssets("DisclaimerColor")
    static let textDisclaimerColor = UIColor.loadFromAssets("TextDisclaimerColor")
    static let separatorColor = UIColor.loadFromAssets("SeparatorColor")
    static let facebook = UIColor.init(named: "FacebookColor")
    static let secondaryText =  UIColor.init(named: "text_secondary")
    static let secondaryTextLight =  UIColor.init(named: "text_secondary_light")
    
    
    // MARK: - UIColors States
    static let disabledState = UIColor.loadFromAssets("state_disabled")
    static let enabledState = UIColor.loadFromAssets("state_enabled")
    static let rejectState =  UIColor.loadFromAssets("state_reject")
    static let warningState =  UIColor.loadFromAssets("state_warning")
}


public extension UIColor {
    class func loadFromAssets(_ name: String) -> UIColor {
        return UIColor(named: name, in: Bundle.module, compatibleWith: nil) ?? UIColor.orange
    }
}

public extension UIImage {
    class func loadFromAssets(_ name: String) -> UIImage {
        return UIImage(named: name, in: Bundle.module, compatibleWith: nil) ?? UIImage()
    }
}
