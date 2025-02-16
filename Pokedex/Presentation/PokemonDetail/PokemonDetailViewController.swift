//
//  PokemonDetailBuilder.swift
//  Pokedex
//
//  Created by Junior Quevedo Gutiérrez  on 16/02/25.
//

import Foundation
import BDRModel

protocol RYDetailRecipeView: BaseView {
    var onCompletion: BDRCompletionFlowBlock? { get set }
}
