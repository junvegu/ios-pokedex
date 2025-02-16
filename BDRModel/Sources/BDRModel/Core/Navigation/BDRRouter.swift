//
//  BDRRouter.swift
//  BDRRouter
//
//  Created by Maksim Kazachkov on 16.08.17.
//  Copyright © 2017 Umbrella. All rights reserved.
//
import UIKit

// MARK:- Typealiases
public typealias CompletionBlock      = ()       -> Void
public typealias AlertCompletionBlock = (String) -> Void
public typealias RouterCompletions = [UIViewController : CompletionBlock]

open class BDRRouter {
    
    // MARK:- Private variables
    fileprivate weak var rootController: UINavigationController?
    
    fileprivate var completions: RouterCompletions
    
    public init(rootController: UINavigationController) {
        self.rootController = rootController
        rootController.navigationBar.prefersLargeTitles = true
        rootController.navigationBar.sizeToFit()
        rootController.navigationItem.largeTitleDisplayMode = .always
        rootController.extendedLayoutIncludesOpaqueBars = true
        rootController.view.backgroundColor = .white
        completions = [:]
    }
    
    public var toPresent: UIViewController? {
        return rootController
    }
    
    public var topNavigation: UINavigationController? {
        return rootController
    }
    
    public func changeRoot(_ nav: UINavigationController) {
        self.rootController = nav
    }

}

// MARK:- Private methods
private extension BDRRouter {
    func runCompletion(for controller: UIViewController) {
        guard let completion = completions[controller] else { return }
        completion()
        completions.removeValue(forKey: controller)
    }
}

// MARK:- Routable
extension BDRRouter: Routable {
 
    
    public func present(transition: BDRTypeTransition, _ module: Presentable?, animated: Bool, index: Int? = nil) {
        switch transition {
        case .tabBar:
            guard let rootTab = rootController?.viewControllers.first as? UITabBarController,
                  let indexTab = index,
                  let presentVC = module?.toPresent,
                  let navigationTab = rootTab.viewControllers?[indexTab] as? UINavigationController else {
                      return
                  }
            navigationTab.viewControllers = [presentVC]
            rootController = navigationTab
        case .push:
            push(module, animated: animated)
        case .modal:
            present(module, animated: animated)
        case .replaceRoot:
            setRootModule(module)
        }
    }
    public func present(transition: BDRTypeTransition, _ module: Presentable?, animated: Bool) {
        switch transition {
        case .tabBar:
            break
        case .push:
            push(module, animated: animated)
        case .modal:
            present(module, animated: animated)
        case .replaceRoot:
            setRootModule(module)
        }
    }

    public func present(_ module: Presentable?) {
        present(module, animated: true)
    }
    
    public func present(_ module: Presentable?, animated: Bool) {
        guard let controller = module?.toPresent else { return }
        rootController?.present(controller, animated: animated, completion: nil)
    }
    
    public func push(_ module: Presentable?)  {
        push(module, animated: true)
    }
    
    public func push(_ module: Presentable?, animated: Bool)  {
        push(module, animated: animated, completion: nil)
    }
    
    public func push(_ module: Presentable?, animated: Bool, completion: CompletionBlock?) {
        guard
            let controller = module?.toPresent,
            !(controller is UINavigationController)
        else { assertionFailure("⚠️Deprecated push UINavigationController."); return }
        
        if let completion = completion {
            completions[controller] = completion
        }
        if let checkTabSelectedNavigation = rootController?.viewControllers.first as? UITabBarController,
           let selected = checkTabSelectedNavigation.selectedViewController as? UINavigationController {
            selected.pushViewController(controller, animated: animated)
        } else {
            rootController?.pushViewController(controller, animated: animated)
        }
    }
    
    public func popModule()  {
        popModule(animated: true)
    }
    
    public  func popModule(animated: Bool)  {
        if let controller = rootController?.popViewController(animated: animated) {
            runCompletion(for: controller)
        }
    }
    
    public func dismissModule() {
        dismissModule(animated: true, completion: nil)
    }
    
    public func dismissModule(animated: Bool, completion: CompletionBlock?) {
        rootController?.dismiss(animated: animated, completion: completion)
    }
    
    public func setRootModule(_ module: Presentable?) {
        setRootModule(module, hideBar: false)
    }
    
    public func setRootModule(_ module: Presentable?, hideBar: Bool) {
        guard let controller = module?.toPresent else { return }
        rootController?.setViewControllers([controller], animated: false)
        rootController?.isNavigationBarHidden = hideBar
    }
    
    public func popToRootModule(animated: Bool) {
        if let controllers = rootController?.popToRootViewController(animated: animated) {
            controllers.forEach { controller in
                runCompletion(for: controller)
            }
        }
    }
}
