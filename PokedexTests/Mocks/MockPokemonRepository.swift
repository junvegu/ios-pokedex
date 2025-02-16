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
    private(set) var lastLimit: Int?
    private(set) var lastOffset: Int?
    
    func getPokemons(limit: Int, offset: Int) async throws -> [Pokemon] {
        getPokemonsCalled = true
        lastLimit = limit
        lastOffset = offset
        return PokemonStub.pokemonList
    }
}
