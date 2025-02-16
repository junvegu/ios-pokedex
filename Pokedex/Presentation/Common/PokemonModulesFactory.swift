//
//  PokemonModulesFactory.swift
//  PokedexTests
//
//  Created by Junior Quevedo Gutiérrez  on 16/02/25.
//

import Foundation

protocol PokemonModulesFactory {
    func buildListPokemons(coordinator: PokemonsCoordinator) -> PokemonListView?
    func buildDetailPokemon(with pokemon: Pokemon, coordinator: PokemonsCoordinatorDelegate) -> RYDetailRecipeView?
}

final class ModulesFactoryDefault {}

extension ModulesFactoryDefault: PokemonModulesFactory {
    func buildListPokemons(coordinator: PokemonsCoordinator) -> PokemonListView? {
        return PokemonListViewBuilder()
            .setGetFirstGenPokemonsUseCase()
            .setSearchPokemonsUseCase()
            .build()
    }
    
    func buildDetailPokemon(with pokemon: Pokemon, coordinator: PokemonsCoordinatorDelegate) -> RYDetailRecipeView? {
        return nil
    }
}
