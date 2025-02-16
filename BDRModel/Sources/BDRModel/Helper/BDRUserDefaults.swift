//
//  UserDefault.swift
//  
//
//  Created by Junior Quevedo Gutiérrez  on 7/02/24.
//

import Foundation
@propertyWrapper
public struct UserDefault<Value> {
    public let key: String
    public let defaultValue: Value
    
    public init(key: String, defaultValue: Value) {
        self.key = key
        self.defaultValue = defaultValue
    }
    public var container: UserDefaults = .standard

    public var wrappedValue: Value {
        get {
            return container.object(forKey: key) as? Value ?? defaultValue
        }
        set {
            container.set(newValue, forKey: key)
        }
    }
}
