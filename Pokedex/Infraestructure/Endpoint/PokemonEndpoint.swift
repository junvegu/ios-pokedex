//
//  PokemonEndpoint.swift
//  Pokedex
//
//  Created by Junior Quevedo Gutiérrez  on 15/02/25.
//
import Foundation
import BDRCoreNetwork
import Alamofire

enum PokemonEndpoint  {
    case list
    
    var baseURL: String {
        return BDRCoreNetwork.shared.config.urlBase
    }

    var path: String {
        switch self {
        case .list:
            return "pokemon/"
        }
    }

    var method: HTTPMethod {
        switch self {
        case .list:
            return .get
        }
    }
    
    var parameters: [String: Any]? {
       return nil
    }
}
