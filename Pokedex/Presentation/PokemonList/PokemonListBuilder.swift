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
    func build() -> UIViewController
}

final class PokemonListViewBuilder: PokemonListViewBuilderProtocol {
    private var searchPokemonsUseCase: SearchPokemonsUseCaseProtocol?
    private var getFirstGenPokemonsUseCase: GetFirstGenPokemonsUseCaseProtocol?

    func setSearchPokemonsUseCase(
        _ useCase: SearchPokemonsUseCaseProtocol = SearchPokemonsUseCase()
    ) -> Self {
        self.searchPokemonsUseCase = useCase
        return self
    }

    func setGetFirstGenPokemonsUseCase(
        _ useCase: GetFirstGenPokemonsUseCaseProtocol = GetFirstGenPokemonsUseCase()
    ) -> Self {
        self.getFirstGenPokemonsUseCase = useCase
        return self
    }

    func build() -> UIViewController {
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
        let viewController = PokemonListViewController(viewModel: viewModel)
        return viewController
    }
}


import SwiftUI

struct PokemonViewController_Previews: PreviewProvider {
    static var previews: some View {
        ViewControllerPreview {
            let vc = PokemonListViewBuilder()
                .setGetFirstGenPokemonsUseCase()
                .setSearchPokemonsUseCase()
                .build()
            return vc
        }
        .previewDevice("iPhone 14 Pro")
    }
}

/// ViewControllerPreview - Permite usar UIViewController en SwiftUI Previews
struct ViewControllerPreview<ViewController: UIViewController>: UIViewControllerRepresentable {
    let viewControllerBuilder: () -> ViewController
    
    init(_ viewControllerBuilder: @escaping () -> ViewController) {
        self.viewControllerBuilder = viewControllerBuilder
    }
    
    func makeUIViewController(context: Context) -> ViewController {
        return viewControllerBuilder()
    }
    
    func updateUIViewController(_ uiViewController: ViewController, context: Context) {}
}
