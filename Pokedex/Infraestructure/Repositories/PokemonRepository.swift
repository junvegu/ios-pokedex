//
//  PokemonRepository.swift
//  Pokedex
//
//  Created by Junior Quevedo Gutiérrez  on 15/02/25.
//

import Foundation

protocol PokemonRepositoryProtocol {
    func getPokemons(limit: Int, offset: Int) async throws -> [Pokemon]
}

final class PokemonRepository: PokemonRepositoryProtocol {
    private let remoteDataSource: PokemonRemoteDataSourceProtocol
    
    init(remoteDataSource: PokemonRemoteDataSourceProtocol) {
        self.remoteDataSource = remoteDataSource
    }
    
    func getPokemons(limit: Int, offset: Int) async throws -> [Pokemon] {
        return try await remoteDataSource.fetchPokemons(limit: limit, offset: offset)
    }
}

