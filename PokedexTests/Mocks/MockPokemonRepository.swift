//
//  MockPokemonRepository.swift
//
//
//  Created by Junior Quevedo Gutiérrez  on 16/02/25.
//

import Foundation
@testable import Pokedex
final class MockPokemonRepository: PokemonRepositoryProtocol {
    private(set) var getPokemonsCalled = false
    private(set) var fetchPokemonDetailCalled = false
    
    private(set) var lastLimit: Int?
    private(set) var lastOffset: Int?
    private(set) var lastPokemonId: Int?
    var shouldThrowError = false
    
    // MARK: - getPokemons
    func getPokemons(limit: Int, offset: Int) async throws -> [Pokemon] {
        getPokemonsCalled = true
        lastLimit = limit
        lastOffset = offset
        
        if shouldThrowError {
            throw NSError(domain: "PokemonRepositoryError", code: 500, userInfo: [NSLocalizedDescriptionKey: "Failed to fetch Pokemons"])
        }
        
        return PokemonStub.pokemonList
    }
    
    // MARK: - fetchPokemonDetail
    func fetchPokemonDetail(id: Int) async throws -> PokemonDetail {
        fetchPokemonDetailCalled = true
        lastPokemonId = id
        
        if shouldThrowError {
            throw NSError(domain: "PokemonRepositoryError", code: 404, userInfo: [NSLocalizedDescriptionKey: "Pokemon not found"])
        }
        
        return PokemonDetailStub.bulbasaurDetail
    }
}
