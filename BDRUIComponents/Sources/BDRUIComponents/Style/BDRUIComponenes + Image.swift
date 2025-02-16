//
//  File.swift
//  
//
//  Created by Junior Quevedo Gutiérrez  on 21/02/24.
//

import Foundation
import UIKit


public extension UIImage {
    static let imagePlaceholder = UIImage.loadFromAssets("GeneralPlaceholder")
    static let visa = UIImage.loadFromAssets("Visa")
    static let cash = UIImage.loadFromAssets("Cash")
    static let dinersClub = UIImage.loadFromAssets("Diners Club")
    static let jcb = UIImage.loadFromAssets("JCB")
    static let masterCard = UIImage.loadFromAssets("MasterCard")
    static let unionPay = UIImage.loadFromAssets("UnionPay")
    static let coins = UIImage.loadFromAssets("coins")
    static let amex = UIImage.loadFromAssets("Amex")
    
    
    static let googelMaps = UIImage.loadFromAssets("ic_google_maps")
    static let waze = UIImage.loadFromAssets("ic_waze")
    static let appleMaps = UIImage.loadFromAssets("mapapple")
    static let ubser = UIImage.loadFromAssets("ic_uber")
    
    
    struct Icon {
        public static let calendar = UIImage.loadFromAssets("ic_calendar")
        public static let history = UIImage.loadFromAssets("ic_history")
    }
}
