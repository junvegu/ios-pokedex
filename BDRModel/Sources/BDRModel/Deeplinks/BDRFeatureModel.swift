//
//  BDRFeatureModel.swift
//  
//
//  Created by Junior on 16/11/22.
//

import Foundation
import UIKit

public enum BDRTypeTransition: String {
    case tabBar, push, modal, replaceRoot
    public var value: String {
        switch self {
        case .push:
            return "push"
        case .modal:
            return "modal"
        case .replaceRoot:
            return "replaceRoot"
        case .tabBar:
            return "tabBar"
        }
    }
}

public protocol BDRFeatureModel {
    static var module: BDRFeatureModel { get }
    func isTransitionAvailable(for key: String) -> Bool
}


/// Assembly for preparing transition for one specific module
public protocol RoutingAssembly {

    /// Method finds endpoint for transition path passed into method
    /// - Parameter key: transition path
    func endpoint(for key: String, parameters: [String: String]?) -> RoutingEndpoint.Type?
}

/// Protocol describes endpoint
public protocol RoutingEndpoint: AnyObject {

    /// Check whether transition available with this endpoint
    var isAvailable: Bool { get }
    init()

    /// Starts transition in specified navigation controller
    func startTransition(in navigation: UINavigationController?, parameters: [String: String]?)
}


/*
    Error handling during transition
    in this example we only cover unsupported transition - endpoint doesn't exists in assemblies
    unavailable transition - transition turned off for some reason
*/
public protocol RoutingErrorHandlerProtocol {
    func handleUnavailableTransition()
    func handleUnsupportedTransition()
}

public final class RoutingErrorHandler: RoutingErrorHandlerProtocol {
    public func handleUnsupportedTransition() {
        let alert = UIAlertController(title: "Unsupported transition", message: "This transition is unsupported", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "ОК", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        UIApplication.shared.windows.first?.rootViewController?.present(alert, animated: true, completion: nil)
    }

    public func handleUnavailableTransition() {
        let alert = UIAlertController(title: "Unavailable transition", message: "This transition is unavailable", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "ОК", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        UIApplication.shared.windows.first?.rootViewController?.present(alert, animated: true, completion: nil)
    }
}



/// Protocol with main logic for router
public protocol RoutingProvider {

    /// Appends new assembly for transition, in our case module is assembly, but it can be any other object conforming to RoutingAssembly protocol
    /// - Parameter assembly: new assembly
    func append(assembly: RoutingAssembly)

    /// Start transition with specified parameters
    /// - Parameters:
    ///   - key: transition key, for example transition1
    ///   - options: options received within method openURL in AppDelegate
    func startTransition(key: String, options: [UIApplication.OpenURLOptionsKey : Any]?, parameters: [String: String]?)

    /// If you want your code be clean, you can pass navigation controller to router so endpoints could use it
    /// - Parameter navigation: navigation controller that should open new screen
    func set(navigation: UINavigationController)

    /// Error handler to show error during transition, cleans up router from error handling
    func set(errorHandler: RoutingErrorHandlerProtocol)
}

public enum BDRDeepLinkParams {
    public static let transition = "transition"
    public static let origin = "origin"
    public static let data = "data"
    public static let numTab = "numTab"
}
public final class BDRDeepLinkRouter {
    public static let shared = BDRDeepLinkRouter()
    public static var urlScheme = "\( Bundle.main.bundleIdentifier ?? "deeplink-bederr")://"
    public var assemblies = [RoutingAssembly]()
    public var topViewController: UINavigationController?
    private var errorHandler: RoutingErrorHandlerProtocol?
    public init() {}
}

extension BDRDeepLinkRouter: RoutingProvider {
    public func startTransition(key: String, options: [UIApplication.OpenURLOptionsKey : Any]?, parameters: [String : String]?) {
        /// Pass througth all assemblies to find needed endpoint to perform transition
        for assembly in assemblies {
            guard let endpointType = assembly.endpoint(for: key, parameters: parameters) else { continue }
            let endpoint = endpointType.init()
            if endpoint.isAvailable {
               // if let checkTabSelectedNavigation = topViewController?.viewControllers.first as? UITabBarController,
               //    let selected = checkTabSelectedNavigation.selectedViewController?.navigationController {
                //    endpoint.startTransition(in: selected, parameters: parameters)
               // } else {
                    endpoint.startTransition(in: topViewController, parameters: parameters)

                //}
                
            } else {
                errorHandler?.handleUnavailableTransition()
            }
            return
        }
        errorHandler?.handleUnsupportedTransition()
    }

    public func append(assembly: RoutingAssembly) {
        assemblies.append(assembly)
    }

    public func set(navigation: UINavigationController) {
        navigation.navigationItem.largeTitleDisplayMode = .never
        topViewController = navigation
    }

    public func set(errorHandler: RoutingErrorHandlerProtocol) {
        self.errorHandler = errorHandler
    }
}
