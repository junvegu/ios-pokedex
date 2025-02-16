//
//  File.swift
//  
//
//  Created by Junior on 30/10/22.
//

import Foundation
struct DeepLinkURLConstants {
  static let login = "login"
  static let home = "home"
}

public enum DeepLinkOption {
  case login
  case home
    
  public static func build(with userActivity: NSUserActivity) -> DeepLinkOption? {
    if userActivity.activityType == NSUserActivityTypeBrowsingWeb,
      let url = userActivity.webpageURL,
      let _ = URLComponents(url: url, resolvingAgainstBaseURL: true) {
      //TODO: extract string and match with DeepLinkURLConstants
    }
    return nil
  }
  
  public static func build(with dict: [String : AnyObject]?) -> DeepLinkOption? {
    guard let id = dict?["launch_id"] as? String else { return nil }
    
    switch id {
      case DeepLinkURLConstants.login: return .home
      case DeepLinkURLConstants.home: return .login
      default: return nil
    }
  }
}
