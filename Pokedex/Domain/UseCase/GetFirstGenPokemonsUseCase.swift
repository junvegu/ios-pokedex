//
//  UseCase.swift
//  Pokedex
//
//  Created by Junior Quevedo Gutiérrez  on 15/02/25.
//
import Foundation

protocol GetFirstGenPokemonsUseCaseProtocol {
    func execute() async throws -> [Pokemon]
}

final class GetFirstGenPokemonsUseCase: GetFirstGenPokemonsUseCaseProtocol {
    private let repository: PokemonRepositoryProtocol
    private let firstGenLimit = 151
    private let firstGenOffset = 0
    
    init(repository: PokemonRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute() async throws -> [Pokemon] {
        return try await repository.getPokemons(
            limit: firstGenLimit,
            offset: firstGenOffset
        )
    }
}
