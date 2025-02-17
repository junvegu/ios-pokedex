//
//  GetPokemonDetailUseCaseTests.swift
//  PokedexTests
//
//  Created by Junior Quevedo Gutiérrez  on 17/02/25.
//

import Foundation
import XCTest
@testable import Pokedex

final class GetPokemonDetailUseCaseTests: XCTestCase {

    func testExecute_ReturnsPokemonDetail() async throws {
        // given
        let mockRepository = MockPokemonRepository()
        let expectedDetail = PokemonDetailStub.bulbasaurDetail
        let useCase = GetPokemonDetailUseCase(repository: mockRepository)

        // when
        let detail = try await useCase.execute(id: 1)

        // then
        XCTAssertEqual(detail.base.id, expectedDetail.base.id)
        XCTAssertEqual(detail.base.name, expectedDetail.base.name)
    }

    func testExecute_ThrowsError() async throws {
        // given
        let mockRepository = MockPokemonRepository()
        mockRepository.shouldThrowError = true
        let useCase = GetPokemonDetailUseCase(repository: mockRepository)

        // when
        do {
            _ = try await useCase.execute(id: 1)
            XCTFail("Se esperaba un error, pero se obtuvo un resultado exitoso.")
        } catch {
            
        }
    }
}
