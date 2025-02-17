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
    private var dataSource: PokemonDataSourceMock!
    
    override func setUp() {
        super.setUp()
        dataSource = PokemonDataSourceMock()
    }
    
    override func tearDown() {
        dataSource = nil
        super.tearDown()
    }
    
    func testFetchPokemons_Success() async throws {
        // Given
        let mockNetwork = MockNetworkRequest(result: .success(PokemonStub.jsonResponse))
        let dataSource = PokemonRemoteDataSource(networkRequest: mockNetwork)
        
        // When
        let result = try await dataSource.fetchPokemons(limit: 2, offset: 0)
        
        // Then
        XCTAssertEqual(result.count, 2)
        XCTAssertEqual(result.first?.name, "Bulbasaur")
        XCTAssertEqual(result.last?.name, "Ivysaur")
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
    
    func testFetchPokemonDetail_Success() async throws {
        let detail = try await dataSource.fetchPokemonDetail(id: 1)
        
        XCTAssertTrue(dataSource.fetchPokemonDetailCalled, "fetchPokemonDetail should be called")
        XCTAssertEqual(dataSource.lastPokemonId, 1)
        XCTAssertEqual(detail.base.name, "Bulbasaur")
        XCTAssertEqual(detail.types.count, 2)
    }
    
    func testFetchPokemonDetail_Failure() async {
        dataSource.shouldThrowError = true
        
        do {
            _ = try await dataSource.fetchPokemonDetail(id: 999)
            XCTFail("Expected error, but got success")
        } catch {
            XCTAssertTrue(dataSource.fetchPokemonDetailCalled, "fetchPokemonDetail should be called even on error")
            XCTAssertEqual((error as NSError).code, 404)
        }
    }
}
