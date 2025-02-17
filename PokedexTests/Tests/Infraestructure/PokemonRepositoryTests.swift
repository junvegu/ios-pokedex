//
//  File.swift
//
//
//  Created by Junior Quevedo Gutiérrez  on 16/02/25.
//

import Foundation
@testable import Pokedex
import XCTest

final class PokemonRepositoryTests: XCTestCase {
    
    func testGetPokemons_DelegatesToDataSource() async throws {
        // Given
        let spy = SpyPokemonRemoteDataSource()
        let repository = PokemonRepository(remoteDataSource: spy)
        
        // When
        _ = try await repository.getPokemons(limit: 2, offset: 0)
        
        // Then
        XCTAssertTrue(spy.fetchPokemonsCalled, "fetchPokemons should have been called")
        XCTAssertEqual(spy.lastLimit, 2)
        XCTAssertEqual(spy.lastOffset, 0)
    }
    
    func testGetPokemonDetail_DelegatesToDataSource() async throws {
        // Given
        let spy = SpyPokemonRemoteDataSource()
        let repository = PokemonRepository(remoteDataSource: spy)
        let expectedPokemonID = 1
        
        // When
        _ = try await repository.fetchPokemonDetail(id: expectedPokemonID)
        
        // Then
        XCTAssertTrue(spy.fetchPokemonDetailCalled, "fetchPokemonDetail should have been called")
        XCTAssertEqual(spy.lastPokemonId, expectedPokemonID)
    }
}
