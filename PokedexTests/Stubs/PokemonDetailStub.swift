//
//  PokemonDetailStub.swift
//  PokedexTests
//
//  Created by Junior Quevedo Gutiérrez  on 16/02/25.
//

import Foundation
@testable import Pokedex

struct PokemonDetailStub {
    static let bulbasaurDetail = PokemonDetail(
        base: PokemonStub.bulbasaur,
        height: 0.7,
        weight: 6.9,
        types: [
            PokemonType(name: "grass"),
            PokemonType(name: "poison")
        ],
        description: "Bulbasaur can be seen napping in bright sunlight."
    )
    
    static let charmanderDetail = PokemonDetail(
        base: PokemonStub.charmander,
        height: 0.6,
        weight: 8.5,
        types: [
            PokemonType(name: "fire")
        ],
        description: "Charmander has a preference for hot things."
    )
}
