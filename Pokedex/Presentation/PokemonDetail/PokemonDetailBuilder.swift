//
//  PokemonDetailBuilder.swift
//  Pokedex
//
//  Created by Junior Quevedo Gutiérrez  on 16/02/25.
//

import Foundation
import UIKit

protocol PokemonDetailViewBuilderProtocol {
    func setGetDetailPokemonUseCase(_ useCase: GetPokemonDetailUseCaseProtocol) -> Self
    func setPokemon(pokemon: Pokemon) -> Self
    func build() -> PokemonDetailViewController
}

final class PokemonDetailViewBuilder: PokemonDetailViewBuilderProtocol {
    
    private var getPokemonDetailUseCase: GetPokemonDetailUseCaseProtocol?
    private var pokemon: Pokemon?
    
    func setGetDetailPokemonUseCase(
        _ useCase: GetPokemonDetailUseCaseProtocol = GetPokemonDetailUseCase()
    ) -> Self {
        self.getPokemonDetailUseCase = useCase
        return self
    }
    
    func setPokemon(pokemon: Pokemon) -> Self  {
        self.pokemon = pokemon
        return self
    }
    
    func build() -> PokemonDetailViewController {
        guard let getPokemonDetailUseCase = getPokemonDetailUseCase else {
            fatalError("SearchPokemonsUseCase must be set before building PokemonDetailViewController")
        }
        guard let pokemon = pokemon else {
            fatalError("pokemon must be set before building PokemonDetailViewController")
        }
        
        let viewModel = PokemonDetailViewModel(
            pokemon: pokemon,
            getPokemonDetail: getPokemonDetailUseCase
        )
        let viewController = PokemonDetailViewController(viewModel: viewModel)
        viewController.navigationItem.title = pokemon.name
        return viewController
    }
}


