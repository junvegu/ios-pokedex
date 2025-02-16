//
//  PokemonListResponse+DomainMappin.swift
//  Pokedex
//
//  Created by Junior Quevedo Gutiérrez  on 15/02/25.
//

import Foundation
extension PokemonListResponse {
    func toDomain(offset: Int = 0) -> [Pokemon] {
        return results.enumerated().map { index, item in
            let id = offset + index + 1
            return Pokemon(
                id: id,
                name: item.name.capitalized,
                url: item.url
            )
        }
    }
}
