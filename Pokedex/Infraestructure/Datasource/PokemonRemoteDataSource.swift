//
//  PokemonRemoteDataSource.swift
//  Pokedex
//
//  Created by Junior Quevedo Gutiérrez  on 15/02/25.
//

import Foundation
import BDRCoreNetwork

final class PokemonRemoteDataSource: PokemonRemoteDataSourceProtocol {
    private let networkRequest: BederrApiManager
    
    init(networkRequest: BederrApiManager = BederrApiManager.shared) {
        self.networkRequest = networkRequest
    }
    
    func fetchPokemons(limit: Int, offset: Int) async throws -> [Pokemon] {
        let endpoint = PokemonEndpoint.list
        return try await withCheckedThrowingContinuation { continuation in
            networkRequest
                .setEndpoint(endpoint.path, .v2)
                .setHttpMethod(endpoint.method)
                .setParameter(endpoint.parameters)
                .subscribeAndReceivedData { result in
                    switch result {
                    case .success(let dataRaw):
                        guard let rawData = dataRaw as? Data,
                              let response = PokemonListResponse.decodeJsonData(rawData) else {
                            continuation.resume(throwing: BDRCoreNetworkError.malformedRequest)
                            return
                        }
                        
                        let pokemons = response.toDomain()
                        continuation.resume(returning: pokemons)
                        
                    case .failure(let error):
                        continuation.resume(throwing: error)
                    }
                }
        }
    }
}
