//
//  GetFirstGenPokemonsUseCaseTests.swift
//
//
//  Created by Junior Quevedo Gutiérrez  on 16/02/25.
//

import Foundation
@testable import Pokedex
import XCTest

final class GetFirstGenPokemonsUseCaseTests: XCTestCase {
    
    func testExecute_CallsRepositoryWithFirstGenLimit() async throws {
        // Given
        let mockRepository = MockPokemonRepository()
        let useCase = GetFirstGenPokemonsUseCase(repository: mockRepository)
        
        // When
        _ = try await useCase.execute()
        
        // Then
        XCTAssertTrue(mockRepository.getPokemonsCalled)
        XCTAssertEqual(mockRepository.lastLimit, 151)
        XCTAssertEqual(mockRepository.lastOffset, 0)
    }
    
    func testExecute_ReturnsPokemonList() async throws {
        // Given
        let mockRepository = MockPokemonRepository()
        let useCase = GetFirstGenPokemonsUseCase(repository: mockRepository)
        
        // When
        let pokemons = try await useCase.execute()
        
        // Then
        XCTAssertEqual(pokemons.count, 2)
        XCTAssertEqual(pokemons.first?.name, "bulbasaur")
    }
}
