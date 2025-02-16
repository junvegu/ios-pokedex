//
//  PokemonCoordinatorFactory.swift
//  PokedexTests
//
//  Created by Junior Quevedo Gutiérrez  on 16/02/25.
//

import Foundation
import BDRModel

protocol Coordinatable: AnyObject {
    func start()
}

protocol CoordinatorOuput: AnyObject {
    var completionFlow: BDRCompletionFlowBlock? { get set }
}

protocol CoordinatorFactory {
    func makeRecipesCoordinator(router: Routable, transition: BDRTypeTransition) -> Coordinatable & CoordinatorOuput
}

final class CoordinatorFactoryDefault {
    static let shared = CoordinatorFactoryDefault()
    private let moduleFactory = ModulesFactoryDefault()
}

extension CoordinatorFactoryDefault: CoordinatorFactory {
    func makeRecipesCoordinator(router: Routable, transition: BDRTypeTransition) -> Coordinatable & CoordinatorOuput {
        return PokemonsCoordinator(router: router, transition: transition)
    }
}
