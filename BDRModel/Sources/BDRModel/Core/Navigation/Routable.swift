//
//  Routable.swift
//  
//
//  Created by Junior on 22/10/22.
//

import Foundation
import UIKit


public protocol Routable: Presentable {
    
    func present(transition: BDRTypeTransition, _ module: Presentable?, animated: Bool, index: Int?)
    func present(transition: BDRTypeTransition, _ module: Presentable?, animated: Bool)

    func present(_ module: Presentable?)
    func present(_ module: Presentable?, animated: Bool)
    
    func push(_ module: Presentable?)
    func push(_ module: Presentable?, animated: Bool)
    func push(_ module: Presentable?, animated: Bool, completion: CompletionBlock?)
    
    func popModule()
    func popModule(animated: Bool)
    
    func dismissModule()
    func dismissModule(animated: Bool, completion: CompletionBlock?)
    
    func setRootModule(_ module: Presentable?)
    func setRootModule(_ module: Presentable?, hideBar: Bool)
    
    func popToRootModule(animated: Bool)
}
public protocol Presentable {
    var toPresent: UIViewController? { get }
    var topNavigation: UINavigationController? { get }

    func changeRoot(_ nav: UINavigationController)
}


public protocol Coordinatable: AnyObject {
    func start()
}
