//
//  PokemonSnapshotTests.swift
//  PokedexTests
//
//  Created by Junior Quevedo Gutiérrez  on 16/02/25.
//

import Foundation
import XCTest
import SnapshotTesting
@testable import Pokedex

final class PokemonListSnapshotTests: XCTestCase {

    func testPokemonListViewSnapshot() {
        let vc = givenView()
        vc.loadViewIfNeeded() // Ensures viewDidLoad() runs

        let expectation = XCTestExpectation(description: "Wait for UI to update")

        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 2.0)
        assertSnapshot(of: vc, as: .image, record: false)
    }
    
    func testPokemonDetailViewSnapshot() {
        let vc = givenDetailView()
        vc.loadViewIfNeeded()

        let expectation = XCTestExpectation(description: "Wait for UI to update")

        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 3.0)
        assertSnapshot(of: vc, as: .image, record: false)
    }
}


extension PokemonListSnapshotTests {
    
    func givenView() -> UIViewController {
        let datasource = PokemonDataSourceMock()
        let repository = PokemonRepository(remoteDataSource: datasource)
        let viewController = PokemonListViewBuilder()
            .setGetFirstGenPokemonsUseCase(GetFirstGenPokemonsUseCase(repository: repository))
            .setSearchPokemonsUseCase()
            .build()
        return viewController
    }
    
    func givenDetailView() -> UIViewController {
        let datasource = PokemonDataSourceMock()
        let repository = PokemonRepository(remoteDataSource: datasource)
        let viewController = PokemonDetailViewBuilder()
            .setGetDetailPokemonUseCase(GetPokemonDetailUseCase(repository: repository))
            .setPokemon(pokemon: .mockCharmander)
            .build()
        return viewController
    }
}
