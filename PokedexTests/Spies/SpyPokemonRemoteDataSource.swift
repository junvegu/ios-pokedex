//
//  SpyPokemonRemoteDataSource.swift
//
//
//  Created by Junior Quevedo Gutiérrez  on 16/02/25.
//

import Foundation
@testable import Pokedex

final class SpyPokemonRemoteDataSource: PokemonRemoteDataSourceProtocol {
    private(set) var fetchPokemonsCalled = false
    private(set) var lastLimit: Int?
    private(set) var lastOffset: Int?
    
    func fetchPokemons(limit: Int, offset: Int) async throws -> [Pokemon] {
        fetchPokemonsCalled = true
        lastLimit = limit
        lastOffset = offset
        return PokemonStub.pokemonList
    }
}
