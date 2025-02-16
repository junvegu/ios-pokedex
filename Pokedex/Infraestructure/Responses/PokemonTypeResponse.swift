//
//  PokemonTypeResponse.swift
//  Pokedex
//
//  Created by Junior Quevedo Gutiérrez  on 16/02/25.
//

import Foundation

struct PokemonTypeResponse: Codable {
    let slot: Int
    let type: TypeDetailResponse

    struct TypeDetailResponse: Codable {
        let name: String
        let url: String
    }
}
