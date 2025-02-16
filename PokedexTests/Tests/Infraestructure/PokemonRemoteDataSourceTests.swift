//
//  PokemonRemoteDataSourceTests.swift
//
//
//  Created by Junior Quevedo Gutiérrez  on 16/02/25.
//

import Foundation
import XCTest
@testable import Pokedex
import BDRCoreNetwork
final class PokemonRemoteDataSourceTests: XCTestCase {
    
    func testFetchPokemons_Success() async throws {
        // Given
        let mockNetwork = MockNetworkRequest(result: .success(PokemonStub.jsonResponse))
        let dataSource = PokemonRemoteDataSource(networkRequest: mockNetwork)
        
        // When
        let result = try await dataSource.fetchPokemons(limit: 2, offset: 0)
        
        // Then
        XCTAssertEqual(result.count, 2)
        XCTAssertEqual(result.first?.name, "bulbasaur")
        XCTAssertEqual(result.last?.name, "ivysaur")
    }
    
    func testFetchPokemons_Failure() async throws {
        // Given
        let mockNetwork = MockNetworkRequest(result: .failure(BDRCoreNetworkError.malformedRequest.asBDRError()))
        let dataSource = PokemonRemoteDataSource(networkRequest: mockNetwork)
        
        do {
            // When
            _ = try await dataSource.fetchPokemons(limit: 2, offset: 0)
            XCTFail("Expected error, but got success")
        } catch {
            // Then
            
        }
    }
}
