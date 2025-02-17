//
//  PokemonDetailViewModel.swift
//  Pokedex
//
//  Created by Junior Quevedo Gutiérrez  on 16/02/25.
//

import Foundation
import BDRModel

class PokemonDetailViewModel: BDRViewModelable {
    var liveData: Output = Output()
    private let pokemon: Pokemon
    private let getPokemonDetail: GetPokemonDetailUseCaseProtocol
    weak var coordinator: PokemonsCoordinatorDelegate?
    
    init(
        pokemon: Pokemon,
        getPokemonDetail: GetPokemonDetailUseCaseProtocol
    ) {
        self.pokemon = pokemon
        self.getPokemonDetail = getPokemonDetail
    }
    
    func bind(_ input: Input) {
        switch input {
        case .onViewReady:
            handleOnViewReady()
        }
    }
    
    private func handleOnViewReady() {
        Task {
            liveData.state = .loading
            do {
                let detail = try await getPokemonDetail.execute(id: pokemon.id)
                liveData.state = .showPokemon(detail)
            } catch {
                liveData.state = .error(error.asBDRError())
            }
        }

    }
}

extension PokemonDetailViewModel {
    enum Input {
        case onViewReady
    }
    
    class Output {
        @Published var state: State = .idle
    }
    
    enum State {
        case idle
        case error(Error)
        case loading
        case showPokemon(PokemonDetail)
    }
}

