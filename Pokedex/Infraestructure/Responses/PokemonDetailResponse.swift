//
//  PokemonDetailResponse.swift
//  Pokedex
//
//  Created by Junior Quevedo Gutiérrez  on 16/02/25.
//

import Foundation

struct PokemonDetailResponse: Codable {
    let id: Int
    let name: String
    let height: Double
    let weight: Double
    let types: [PokemonTypeResponse]
    let description: String
}
