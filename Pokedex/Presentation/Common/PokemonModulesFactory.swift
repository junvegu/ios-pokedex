//
//  PokemonModulesFactory.swift
//  PokedexTests
//
//  Created by Junior Quevedo Gutiérrez  on 16/02/25.
//

import Foundation

protocol PokemonModulesFactory {
    func buildListPokemons(coordinator: PokemonsCoordinator) -> PokemonListView?
    func buildDetailPokemon(with pokemon: Pokemon, coordinator: PokemonsCoordinatorDelegate) -> PokemonDetailView?
}

final class ModulesFactoryDefault {}

extension ModulesFactoryDefault: PokemonModulesFactory {
    func buildListPokemons(coordinator: PokemonsCoordinator) -> PokemonListView? {
        return PokemonListViewBuilder()
            .setGetFirstGenPokemonsUseCase()
            .setSearchPokemonsUseCase()
            .setCoordinator(coordinator)
            .build()
    }
    
    func buildDetailPokemon(with pokemon: Pokemon, coordinator: PokemonsCoordinatorDelegate) -> PokemonDetailView? {
        return PokemonDetailViewBuilder()
            .setGetDetailPokemonUseCase()
            .setPokemon(pokemon: pokemon)
            .build()
    }
}
