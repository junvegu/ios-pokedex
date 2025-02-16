//
//  UIAlertController + Helper.swift
//  
//
//  Created by Junior on 22/10/22.
//

import BDRModel
import UIKit

public extension UIAlertController {
    static func showAlert(
        title: String?,
        message: String?,
        tintColor: UIColor? = nil,
        actionBlock: (() -> Void)? = nil)
    {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let alertActionOk = UIAlertAction(title: "Aceptar", style: .destructive) { action in
            actionBlock?()
        }
        let alertActionCancel = UIAlertAction(title: "Cancelar", style: .cancel) { action in
            
        }
        alert.addAction(alertActionOk)
        alert.addAction(alertActionCancel)

        alert.presentInOwnWindow(animated: true, completion: nil)
    }

    static func showAlert(
        title: String?,
        message: String?,
        tintColor: UIColor? = nil,
        inViewController viewController: UIViewController,
        actionBlock: (() -> Void)? = nil)
    {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let alertActionOk = UIAlertAction(title: "OK", style: .default) { action in
            alert.dismiss(animated: true, completion: nil)
            if let actionBlock = actionBlock {
                actionBlock()
            }
        }
        
        alert.addAction(alertActionOk)
        DispatchQueue.main.async(execute: {
            viewController.present(alert, animated: true, completion: nil)
            if tintColor != nil {
                alert.view.tintColor = tintColor!
            }
        })
    }
    
    static func showActionSheet(
        title: String?,
        message: String?,
        viewController: UIViewController,
        actions: [UIAlertAction]?,
        cancelTitle: String,
        tintColor: UIColor?)
    {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        alert.addActions(actions)
        let alertActionCancel = UIAlertAction(title: cancelTitle, style: .cancel, handler: nil)
        alert.addAction(alertActionCancel)
        DispatchQueue.main.async(execute: {
            viewController.present(alert, animated: true, completion: nil)
            if tintColor != nil {
                alert.view.tintColor = tintColor!
            }
        })
    }
    
    func addAction(title: String?, style: UIAlertAction.Style, handler: ((UIAlertAction) -> Void)?) {
        let action = UIAlertAction(title: title, style: style, handler: handler)
        addAction(action)
    }
    
    func addCancelAction(title: String?) {
        let action = UIAlertAction(title: title, style: .cancel, handler: nil)
        addAction(action)
    }
}

// MARK:- Add methods
public extension UIAlertController {
    func addActions(_ actions: [UIAlertAction]?) {
        actions?.forEach { self.addAction($0) }
    }
}

extension UIViewController: Presentable {
    public func changeRoot(_ nav: UINavigationController) {
        //TBD
    }
    
    public var topNavigation: UINavigationController? {
        return nil
    }
    
    public var toPresent: UIViewController? {
        return self
    }
    
    public func showAlert(title: String, message: String? = nil) {
        UIAlertController.showAlert(title            : title,
                                    message          : message,
                                    inViewController : self,
                                    actionBlock      : nil)
    }
}

extension UIAlertController {

    func presentInOwnWindow(animated: Bool, completion: (() -> Void)?) {
        if var topController = UIApplication.shared.keyWindow?.rootViewController  {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            topController.present(self, animated: animated, completion: completion)
        }
    }
}
