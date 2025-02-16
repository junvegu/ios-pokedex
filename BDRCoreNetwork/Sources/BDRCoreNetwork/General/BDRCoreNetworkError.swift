//
//  BDRCoreNetworkError.swift
//  
//
//  Created by Junior on 21/08/22.
//

import Foundation
import BDRModel

public enum BDRCoreNetworkError: LocalizedError, Equatable {
    public static func == (lhs: BDRCoreNetworkError, rhs: BDRCoreNetworkError) -> Bool {
        return lhs == rhs
    }
    
    case unauthorized
    case noInternetConnection
    case malformedRequest
    case malformedDataEncodable
    case customError(BDRError)
    
    public var errorDescription: String? {
        switch self {
        case .unauthorized:
            return "Access is denied. User is unauthorized."
        case .noInternetConnection:
            return "Please check your internet connection and try again later."
        case .malformedRequest:
            return "Error al decodificar la respuesta del servidor, porfavor inténtelo nuevamente"
        case .malformedDataEncodable:
            return "Error al codificar los datos, porfavor inténtelo nuevamente"
        case .customError(let body):
            return body.descriptionError
        }
    }
    
    public var errorData: BDRError? {
        switch self {
        case .unauthorized:
            return nil
        case .noInternetConnection:
            return nil
        case .malformedRequest:
            return nil
        case .malformedDataEncodable:
            return nil
        case .customError(let bederrApiError):
            return bederrApiError
        }
    }
}


public extension NSError {
    
    convenience init(domain: String = "Bederr", code:Int, message:String) {
        let userInfo = [NSLocalizedDescriptionKey:message, NSLocalizedFailureReasonErrorKey:message, NSLocalizedRecoverySuggestionErrorKey:message]
        self.init(domain: domain, code: code, userInfo: userInfo)
    }

}

public extension Error {

    func asBDRError(domain: String = "Error desconocido") -> BDRError {
        if let safeBDRError = self as? BDRError {
            return safeBDRError
        }
        let customError = self.asAFError

        guard let bdrError =  self as? BDRCoreNetworkError else {
            return BDRError.init(detail: domain)
        }
        switch bdrError {
        case .unauthorized, .noInternetConnection, .malformedRequest, .malformedDataEncodable:
            return BDRError.init(detail: bdrError.errorDescription)
        case .customError(let bdrError):
            return bdrError
        }
    }
}
