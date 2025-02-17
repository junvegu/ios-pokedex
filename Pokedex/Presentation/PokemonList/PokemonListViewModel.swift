//
//  PokemonListViewModel.swift
//  PokedexTests
//
//  Created by Junior Quevedo Gutiérrez  on 16/02/25.
//

import Foundation
import BDRModel

class PokemonListViewModel: BDRViewModelable {
    var liveData: Output = Output()

    private let getFirstGenPokemonsUseCase: GetFirstGenPokemonsUseCaseProtocol
    private let searchPokemonsUseCase: SearchPokemonsUseCaseProtocol
    weak var coordinator: PokemonsCoordinatorDelegate?

    init(
          getFirstGenPokemonsUseCase: GetFirstGenPokemonsUseCaseProtocol,
          searchPokemonsUseCase: SearchPokemonsUseCaseProtocol
      ) {
          self.getFirstGenPokemonsUseCase = getFirstGenPokemonsUseCase
          self.searchPokemonsUseCase = searchPokemonsUseCase
      }
    
    func bind(_ input: Input) {
        switch input {
        case .onViewReady, .onRefreshPokemon:
            Task {
                await getPokemons()
            }
        case .onSearchPokemon(let text):
            search(query: text)
        case .didTapPokemon(let pokemon):
            handleTapShowDetail(pokemon)
        }
    }
    
    func search(query: String) {
        let filteredPokemons = searchPokemonsUseCase.execute(query: query, pokemons: liveData.pokemons)
        liveData.state = .searchResults(filteredPokemons)
    }
    
    private func handleTapShowDetail(_ pokemon: Pokemon) {
        coordinator?.navigateTo(.detail(pokemon))
    }
    
    private func getPokemons() async {
        liveData.state = .loading
        do {
            liveData.pokemons = try await getFirstGenPokemonsUseCase.execute()
            liveData.state = .success(liveData.pokemons)
        } catch {
            liveData.state = .error(error.asBDRError())
        }
    }
}
extension PokemonListViewModel {
    enum Input {
        case onViewReady
        case onRefreshPokemon
        case onSearchPokemon(String)
        case didTapPokemon(Pokemon)
    }
    
    class Output {
        @Published var state: Status = .idle
        @Published var pokemons: [Pokemon] = []

    }

    enum Status {
        case idle
        case error(Error)
        case loading
        case success([Pokemon])
        case searchResults([Pokemon])
    }
}
