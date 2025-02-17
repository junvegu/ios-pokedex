//
//  PokemonStub.swift
//  
//
//  Created by Junior Quevedo Gutiérrez  on 16/02/25.
//

import Foundation
@testable import Pokedex

struct PokemonStub {
    static let jsonResponse = """
    {
      "results": [
        {"name": "bulbasaur", "url": "https://pokeapi.co/api/v2/pokemon/1/"},
        {"name": "ivysaur", "url": "https://pokeapi.co/api/v2/pokemon/2/"}
      ]
    }
    """.data(using: .utf8)!
    
    static let pokemonListResponse = PokemonListResponse(
        results: [
            PokemonItem(name: "bulbasaur", url: "https://pokeapi.co/api/v2/pokemon/1/"),
            PokemonItem(name: "ivysaur", url: "https://pokeapi.co/api/v2/pokemon/2/")
        ]
    )
    
    static let pokemonList = [
        Pokemon(id: 1, name: "bulbasaur", url: "https://pokeapi.co/api/v2/pokemon/1/"),
        Pokemon(id: 2, name: "ivysaur", url: "https://pokeapi.co/api/v2/pokemon/2/")
    ]
    
    static let bulbasaur = Pokemon(
         id: 1,
         name: "bulbasaur",
         url: "https://pokeapi.co/api/v2/pokemon/1"
     )
     
     static let charmander = Pokemon(
         id: 4,
         name: "charmander",
         url: "https://pokeapi.co/api/v2/pokemon/4"
     )
     
     static let pokemonListLite: [Pokemon] = [bulbasaur, charmander]
}
