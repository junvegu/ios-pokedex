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
    private(set) var fetchPokemonDetailCalled = false
    private(set) var lastPokemonId: Int?
    private(set) var lastLimit: Int?
    private(set) var lastOffset: Int?
    
    var shouldThrowError = false
    
    func fetchPokemons(limit: Int, offset: Int) async throws -> [Pokemon] {
        fetchPokemonsCalled = true
        lastLimit = limit
        lastOffset = offset
        return PokemonStub.pokemonList
    }
    
    func fetchPokemonDetail(id: Int) async throws -> PokemonDetail {
        fetchPokemonDetailCalled = true
        lastPokemonId = id
        if shouldThrowError {
            throw NSError(domain: "PokemonError", code: 404, userInfo: [NSLocalizedDescriptionKey: "Not Found"])
        }
        return PokemonDetailStub.bulbasaurDetail
    }
}
