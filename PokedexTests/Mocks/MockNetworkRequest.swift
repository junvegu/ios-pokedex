//
//  File.swift
//  
//
//  Created by Junior Quevedo Gutiérrez  on 16/02/25.
//

import Foundation
import BDRCoreNetwork
import Combine

final class MockNetworkRequest: BederrApiManager {
    private let result: Result<Data, Error>
    
    init(result: Result<Data, Error>) {
        self.result = result
        super.init() 

    }
    
    override func receive<S>(subscriber: S) where S : Subscriber, Failure == S.Failure, Output == S.Input {
           // Simula una respuesta basada en el resultado predefinido
        let subscription = MockSubscription(subscriber: subscriber, result: result)
               subscriber.receive(subscription: subscription)
       }
}
final class MockSubscription<S: Subscriber>: Subscription where S.Input == Data, S.Failure == Error {
    private var subscriber: S?
    private let result: Result<Data, Error>
    
    init(subscriber: S, result: Result<Data, Error>) {
        self.subscriber = subscriber
        self.result = result
    }

    func request(_ demand: Subscribers.Demand) {
        // Simulamos una respuesta inmediata según el resultado
        switch result {
        case .success(let data):
            _ = subscriber?.receive(data)
            subscriber?.receive(completion: .finished)
        case .failure(let error):
            subscriber?.receive(completion: .failure(error))
        }
    }

    func cancel() {
        subscriber = nil
    }
}
