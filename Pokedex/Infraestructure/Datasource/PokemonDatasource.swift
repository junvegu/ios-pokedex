//
//  PokemonDatasource.swift
//  Pokedex
//
//  Created by Junior Quevedo Gutiérrez  on 15/02/25.
//

import Foundation

protocol PokemonRemoteDataSourceProtocol {
    func fetchPokemons(limit: Int, offset: Int) async throws -> [Pokemon]
    func fetchPokemonDetail(id: Int) async throws -> PokemonDetail
}
