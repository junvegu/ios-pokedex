//
//  GlobalUISpacing.swift
//  
//
//  Created by Junior on 4/03/23.
//
import Foundation
import UIKit

public struct GlobalUISpacing {
    public enum MarginSizes {
        public static let zero: CGFloat = 0
        public static let xxSmall: CGFloat = 4
        public static let xSmall: CGFloat = 8
        public static let small: CGFloat = 16
        public static let medium: CGFloat = 24
        public static let large: CGFloat = 32
        public static let xLarge: CGFloat = 48
        public static let xxLarge: CGFloat = 64
    }
    
    public static let tableSmallEdgeInsets: UIEdgeInsets = UIEdgeInsets(top: 0,
                                                          left: GlobalUISpacing.MarginSizes.small,
                                                          bottom: 0,
                                                          right: -GlobalUISpacing.MarginSizes.small)
}

public extension CGFloat {
    static let spacingLayout2xSmall: CGFloat = 4
    static let spacingLayout1xSmall: CGFloat = 8
    static let spacingLayoutXSSmall: CGFloat = 12
    static let spacingLayoutSmall: CGFloat = 16
    static let spacingLayoutMedium: CGFloat = 24
    static let spacingLayoutLarge: CGFloat = 32
    static let spacingLayout1xLarge: CGFloat = 48
    static let spacingLayout2xLarge: CGFloat = 64
    
    static let cardHighlightedFactor: CGFloat = 0.96
}


