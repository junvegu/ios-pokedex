//
//  SearchPokemonByText.swift
//  Pokedex
//
//  Created by Junior Quevedo Gutiérrez  on 16/02/25.
//

// SearchPokemonsUseCase.swift
import Foundation

protocol SearchPokemonsUseCaseProtocol {
    func execute(query: String, pokemons: [Pokemon]) -> [Pokemon]
}

final class SearchPokemonsUseCase: SearchPokemonsUseCaseProtocol {
    func execute(query: String, pokemons: [Pokemon]) -> [Pokemon] {
        guard !query.isEmpty else { return pokemons }
        return pokemons.filter { $0.name.lowercased().contains(query.lowercased()) }
    }
}
