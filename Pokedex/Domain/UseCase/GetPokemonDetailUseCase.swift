//
//  GetPokemonDetailUseCase.swift
//  Pokedex
//
//  Created by Junior Quevedo Gutiérrez  on 16/02/25.
//

import Foundation
import Foundation
import Foundation

protocol GetPokemonDetailUseCaseProtocol {
    func execute(id: Int) async throws -> PokemonDetail
}

final class GetPokemonDetailUseCase: GetPokemonDetailUseCaseProtocol {
    private let repository: PokemonRepository

    init(repository: PokemonRepository) {
        self.repository = repository
    }

    func execute(id: Int) async throws -> PokemonDetail {
        let pokemonDetail = try await repository.fetchPokemonDetail(id: id)
        return pokemonDetail
    }
}
