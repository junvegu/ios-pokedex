//
//  BDRUIComponents + UIFont.swift
//  
//
//  Created by Junior on 24/07/22.
//

import Foundation
import UIKit


public extension UIFont {
    
    class func bederrRegular(_ size: CGFloat) -> UIFont {
        return BDRUIComponents.sharedInstance.config.regularFont.withSize(size)
    }
    
    class func bederrBold(_ size: CGFloat) -> UIFont {
        return BDRUIComponents.sharedInstance.config.boldFont.withSize(size)
    }
    
    class func bederrLight(_ size: CGFloat) -> UIFont {
        return BDRUIComponents.sharedInstance.config.lightFont.withSize(size)
    }
    
    class func bederrItalic(_ size: CGFloat) -> UIFont {
        return BDRUIComponents.sharedInstance.config.italicFont.withSize(size)
    }
    
    class func bederrBoldItalic(_ size: CGFloat) -> UIFont {
        return BDRUIComponents.sharedInstance.config.boldItalic.withSize(size)
    }
    
    
}
