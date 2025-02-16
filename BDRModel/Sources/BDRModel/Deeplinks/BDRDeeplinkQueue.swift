//
//  File.swift
//  
//
//  Created by Junior Quevedo Gutiérrez  on 7/02/24.
//

import Foundation
import UIKit

public class BDRDeeplinkQueue {
    public static let shared = BDRDeeplinkQueue()
    public var deepLinkToShow: String = ""
    public static func execute() {
        guard !BDRDeeplinkQueue.shared.deepLinkToShow.isEmpty,
        let url = URL(string: BDRDeeplinkQueue.shared.deepLinkToShow) else {
            return
        }
        UIApplication.shared.open(url,
                                  options: [:],
                                  completionHandler: nil)
        BDRDeeplinkQueue.shared.deepLinkToShow = ""
    }
    
    public static func execute(_ url: String) {
        guard let url = URL(string: url) else {
            return
        }
        UIApplication.shared.open(url,
                                  options: [:],
                                  completionHandler: nil)
    }
}
public extension UserDefaults {
    @UserDefault(key: "fcm_token", defaultValue: "")
    public static var fcmToken: String
}
