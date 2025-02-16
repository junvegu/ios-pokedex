//
//  PokemonCoordinator.swift
//  PokedexTests
//
//  Created by Junior Quevedo Gutiérrez  on 16/02/25.
//

import Foundation
import BDRModel

enum LaunchInstructor {
    case list, detail(Pokemon)
    
    static func setup() -> LaunchInstructor {
        return .list
    }
}

protocol PokemonsCoordinatorDelegate: AnyObject {
    func navigateTo(_ flow: LaunchInstructor)
}

// MARK: - HMHomeCoordinator
final class PokemonsCoordinator: PokemonsCoordinatorDelegate, CoordinatorOuput {
    var completionFlow: BDRCompletionFlowBlock?
    
    private let router : Routable
    private let transition : BDRTypeTransition
    private let factory: PokemonModulesFactory
    
    private var instructor: LaunchInstructor {
        return LaunchInstructor.setup()
    }
    
    init(router: Routable,
         transition: BDRTypeTransition,
         factory: PokemonModulesFactory = ModulesFactoryDefault()) {
        self.router  = router
        self.factory = factory
        self.transition = transition
    }
    
    func navigateTo(_ flow: LaunchInstructor) {
        switch flow {
        case .list:
            navigateToListPokemon()
        case .detail(let pokemon):
            navigateToDetailPokemon(with: pokemon)
        }
    }
    
}

// MARK: - Coordinatable
extension PokemonsCoordinator: Coordinatable {
    public func start() {
        navigateTo(.list)
    }
}

private extension PokemonsCoordinator {
    
    func navigateToListPokemon() {
        guard let vc = factory.buildListPokemons(coordinator: self) else {
            return
        }
        router.present(transition: transition, vc, animated: true, index: nil)
    }
    
    func navigateToDetailPokemon(with pokemon: Pokemon) {
        guard let vc = factory.buildDetailPokemon(with: pokemon, coordinator: self) else {
            return
        }
        router.push(vc)
    }
}
