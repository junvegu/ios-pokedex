//
//  PokemonResponse.swift
//  Pokedex
//
//  Created by Junior Quevedo Gutiérrez  on 15/02/25.
//

import Foundation
import BDRModel

struct PokemonListResponse: DecodableMapper {
    let results: [PokemonItem]
}

struct PokemonItem: DecodableMapper {
    let name: String
    let url: String
}
