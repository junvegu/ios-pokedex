//
//  PokemonDetailResponse+Mapper.swift
//  Pokedex
//
//  Created by Junior Quevedo Gutiérrez  on 16/02/25.
//

import Foundation
extension PokemonDetailResponse {
    func toDomain() -> PokemonDetail {
        return  PokemonDetail(
            base: Pokemon(id: id,
                          name: name.capitalized,
                          url: ""),
            height: height,
            weight: weight,
            types: types.map { PokemonType(name: $0.type.name.capitalized)},
            description: "")
    }
}
