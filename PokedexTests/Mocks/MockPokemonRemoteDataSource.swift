//
//  MockPokemonRemoteDataSource.swift
//  PokedexTests
//
//  Created by Junior Quevedo Gutiérrez  on 16/02/25.
//

import Foundation
@testable import Pokedex

// MARK: - Pokemon Mock
extension Pokemon {
    static let mockPikachu = Pokemon(id: 25, name: "Pikachu", url: "https://pokeapi.co/api/v2/pokemon/25/")
    static let mockCharmander = Pokemon(id: 4, name: "Charmander", url: "https://pokeapi.co/api/v2/pokemon/4/")
    static let mockBulbasaur = Pokemon(id: 1, name: "Bulbasaur", url: "https://pokeapi.co/api/v2/pokemon/1/")
    static let mockSquirtle = Pokemon(id: 7, name: "Squirtle", url: "https://pokeapi.co/api/v2/pokemon/7/")
    
    static let allMocks: [Pokemon] = [
        .mockPikachu,
        .mockCharmander,
        .mockBulbasaur,
        .mockSquirtle
    ]
}

// MARK: - PokemonDataSource Mock
class PokemonDataSourceMock: PokemonRemoteDataSourceProtocol {
    private(set) var fetchPokemonsCalled = false
    private(set) var fetchPokemonDetailCalled = false
    
    private(set) var lastLimit: Int?
    private(set) var lastOffset: Int?
    private(set) var lastPokemonId: Int?
    
    var shouldThrowError = false
    
    
    func fetchPokemonDetail(id: Int) async throws -> PokemonDetail {
        fetchPokemonDetailCalled = true
        lastPokemonId = id
        
        if shouldThrowError {
            throw NSError(domain: "PokemonDataSourceError", code: 404, userInfo: [NSLocalizedDescriptionKey: "Pokemon not found"])
        }
        if id == 1 {
            return PokemonDetailStub.bulbasaurDetail
        } else if id == 4 {
            return PokemonDetailStub.charmanderDetail
        } else {
            throw NSError(domain: "PokemonDataSourceError", code: 404, userInfo: [NSLocalizedDescriptionKey: "Pokemon not found"])
        }
    }

    func fetchPokemons(limit: Int, offset: Int) async throws -> [Pokemon] {
        fetchPokemonsCalled = true
        lastLimit = limit
        lastOffset = offset
        
        if shouldThrowError {
            throw NSError(domain: "PokemonDataSourceError", code: 500, userInfo: [NSLocalizedDescriptionKey: "Failed to fetch Pokemons"])
        }
        
        return Pokemon.allMocks
    }
}
