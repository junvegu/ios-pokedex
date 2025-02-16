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
    case list(limit: Int, offSet: Int)
    case detail(id: Int)

    var baseURL: String {
        return BDRCoreNetwork.shared.config.urlBase
    }

    var path: String {
        switch self {
        case .list:
            return "pokemon/"
        case .detail(let id):
            return "pokemon/\(id)"
        }
    }

    var method: HTTPMethod {
        switch self {
        case .list, .detail:
            return .get
        }
    }
    
    var parameters: [String: Any]? {
        switch self {
        case .list(let limit, let offSet):
            return ["limit": limit, "offset": offSet]
        case .detail:
            return nil
        }
    }
}
