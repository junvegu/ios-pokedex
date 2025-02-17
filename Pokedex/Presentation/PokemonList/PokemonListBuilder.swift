//
//  PokemonListBuilder.swift
//  PokedexTests
//
//  Created by Junior Quevedo Gutiérrez  on 16/02/25.
//

import Foundation


import UIKit

protocol PokemonListViewBuilderProtocol {
    func setSearchPokemonsUseCase(_ useCase: SearchPokemonsUseCaseProtocol) -> Self
    func build() -> PokemonListViewController
}

final class PokemonListViewBuilder: PokemonListViewBuilderProtocol {
    private var searchPokemonsUseCase: SearchPokemonsUseCaseProtocol?
    private var getFirstGenPokemonsUseCase: GetFirstGenPokemonsUseCaseProtocol?
    private var coordinator: PokemonsCoordinatorDelegate?
    
    func setSearchPokemonsUseCase(
        _ useCase: SearchPokemonsUseCaseProtocol = SearchPokemonsUseCase()
    ) -> Self {
        self.searchPokemonsUseCase = useCase
        return self
    }
    
    func setCoordinator(
        _ coordinator: PokemonsCoordinatorDelegate?
    ) -> Self {
        self.coordinator = coordinator
        return self
    }
    
    func setGetFirstGenPokemonsUseCase(
        _ useCase: GetFirstGenPokemonsUseCaseProtocol = GetFirstGenPokemonsUseCase()
    ) -> Self {
        self.getFirstGenPokemonsUseCase = useCase
        return self
    }
    
    func build() -> PokemonListViewController {
        guard let searchUseCase = searchPokemonsUseCase else {
            fatalError("SearchPokemonsUseCase must be set before building PokemonViewController")
        }
        
        guard let getFirstGenPokemonsUseCase = getFirstGenPokemonsUseCase else {
            fatalError("GetFirstGenPokemonsUseCase must be set before building PokemonViewController")
        }
        
        let viewModel = PokemonListViewModel(
            getFirstGenPokemonsUseCase: getFirstGenPokemonsUseCase,
            searchPokemonsUseCase: searchUseCase
        )
        viewModel.coordinator = coordinator
        let viewController = PokemonListViewController(viewModel: viewModel)
        viewController.navigationItem.title = "Encuentra tu Pokémon"
        return viewController
    }
}
