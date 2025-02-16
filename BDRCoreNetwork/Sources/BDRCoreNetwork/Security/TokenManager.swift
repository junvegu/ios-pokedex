//
//  TokenManager.swift
//  
//
//  Created by Junior on 5/12/21.
//
import Foundation
import BDRModel

public protocol AppContext {
    var isLogged: Bool { get }
    func setAreas(_ areas: [Area])
    func getAreas() -> [Area]
}
public class AppContextDefault: AppContext {
    public static let shared = AppContextDefault()
    private let tokenManager: TokenManager
    private var areas: [Area] = []

    public init(tokenManager: TokenManager = TokenManager.shared) {
        self.tokenManager = tokenManager
    }

    public var isLogged: Bool {
        return tokenManager.fetchAccessToken() != nil
    }
    
    
    public func setAreas(_ areas: [Area]) {
        self.areas = areas
    }
    
    public func getAreas() -> [Area] {
        return areas
    }
    
}

public class TokenManager {
    let userAccount = "accessToken"
    public static let shared = TokenManager()
    
    let secureStore: SecureStore = {
        let accessTokenQueryable = GenericPasswordQueryable(service: "BederrService")
        return SecureStore(secureStoreQueryable: accessTokenQueryable)
    }()
    
    public func saveAccessToken(bederrToken: BederrAccessToken) {
        do {
            print("SAVE token: \(bederrToken.token)")
            try secureStore.setValue(bederrToken.token, for: userAccount)
        } catch let exception {
            print("Error saving access token: \(exception)")
        }
    }
    
    public func fetchAccessToken() -> String? {
        do {
            let token =  try secureStore.getValue(for: userAccount)
            return token
        } catch let exception {
            print("Error fetching access token: \(exception)")
        }
        return nil
    }
    
    public func clearAccessToken() {
        do {
            return try secureStore.removeValue(for: userAccount)
        } catch let exception {
            print("Error clearing access token: \(exception)")
        }
    }
    
    public func closeSession () {
        clearAccessToken()
        
    }
}
