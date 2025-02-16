//
//  BDRBaseCoordinator.swift
//  
//
//  Created by Junior on 22/10/22.
//

import Foundation

open class BDRBaseCoordinator {
    
    public var childCoordinators: [Coordinatable] = []
        
    // Add only unique object
    
    public func addDependency(_ coordinator: Coordinatable) {
        for element in childCoordinators {
            if element === coordinator { return }
        }
        childCoordinators.append(coordinator)
    }
    
    public func removeDependency(_ coordinator: Coordinatable?) {
        guard
            childCoordinators.isEmpty == false,
            let coordinator = coordinator
            else { return }
        
        for (index, element) in childCoordinators.enumerated() {
            if element === coordinator {
                childCoordinators.remove(at: index)
                break
            }
        }
    }
}
