//
//  UILabel + Height.swift
//  
//
//  Created by Junior on 26/11/22.
//

import UIKit
public extension UILabel {
    var height: CGFloat {
       lineBreakMode = .byWordWrapping
       sizeToFit()
       numberOfLines = Int( frame.width / (UIScreen.main.bounds.width - 4)) + 1
       return frame.height * CGFloat(numberOfLines)
   }
}
