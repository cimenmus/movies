//
//  NetworkBoundPublisher.swift
//  Movies
//
//  Created by mustafa içmen on 9.03.2021.
//

import Foundation
import Combine

struct NetworkBoundPublisher<ResultType>: Publisher {
    
    typealias Output = ResultType
    typealias Failure = Error
    
    private var loadFromNetwork: () -> AnyPublisher<ResultType, AppError>
    private var loadFromDb: () -> AnyPublisher<ResultType, AppError>
    private var saveToDb: (ResultType) -> Void
    
    init(loadFromNetwork: @escaping () -> AnyPublisher<ResultType, AppError>,
         loadFromDb: @escaping () -> AnyPublisher<ResultType, AppError>,
         saveToDb: @escaping (ResultType) -> Void) {
        self.loadFromNetwork = loadFromNetwork
        self.loadFromDb = loadFromDb
        self.saveToDb = saveToDb
    }
    
    func receive<S>(subscriber: S) where S : Subscriber, Self.Failure == S.Failure, Self.Output == S.Input {
        let subscription = NetworkBoundSubscription(loadFromNetwork: loadFromNetwork,
                                                    loadFromDb: loadFromDb,
                                                    saveToDb:saveToDb,
                                                    subscriber: subscriber)
        subscriber.receive(subscription: subscription)
    }
}
