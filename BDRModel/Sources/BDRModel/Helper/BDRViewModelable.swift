//
//  BDRViewModelable.swift
//  
//
//  Created by Junior on 10/09/22.
//

import Combine
import Foundation
import UIKit

public protocol BDRViewModelable {
    associatedtype Input
    associatedtype Output
    
    func bind(_ input: Input)
    
    var liveData: Output { get }
}

public extension UIViewController {
  var topMostViewController : UIViewController {
      
      if let presented = self.presentedViewController {
          return presented.topMostViewController
      }
      
      if let navigation = self as? UINavigationController {
          return navigation.visibleViewController?.topMostViewController ?? navigation
      }
      
      if let tab = self as? UITabBarController {
          return tab.selectedViewController?.topMostViewController ?? tab
      }
      return self
  }
}
public extension UIApplication {
    var topMostViewController : UIViewController? {
        return self.keyWindow?.rootViewController?.topMostViewController
    }
}
