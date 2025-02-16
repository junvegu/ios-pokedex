//
//  Publisher + Subscribe.swift
//  
//
//  Created by Junior on 11/09/22.
//

import Combine
import Foundation

public extension Publisher {
    // MARK: - Subscribe And Received Data From Server -
    func subscribeAndReceivedData(_ qos: DispatchQoS = .background, data: @escaping((Result<Any,Error>) -> ())) {
        subscribe(on: DispatchQueue( label: "rrcombine.queue.\(qos)", qos: qos, attributes: [.concurrent], target: nil))
            .receive(on: DispatchQueue.main)
            .sink { (completion) in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    data(.failure(error))
                }
            } receiveValue: { response in
                data(.success(response))
            }.cancel()
    }
    
    // MARK: - Deferred -
    func setDeferred() -> AnyPublisher<Self.Output, Self.Failure> {
        Deferred { self }
            .eraseToAnyPublisher()
    }
}
