//
//  DatabasePublisher.swift
//  Movies
//
//  Created by mustafa içmen on 9.03.2021.
//

import Foundation
import Combine

struct DatabasePublisher<ResultType>: Publisher {
    
    typealias Output = ResultType
    typealias Failure = Error
    
    private var request: (() -> ResultType?)
    
    init(request: @escaping (() -> ResultType?)) {
        self.request = request
    }
    
    func receive<S: Subscriber>(subscriber: S) where DatabasePublisher.Failure == S.Failure, DatabasePublisher.Output == S.Input {
            let subscription = DatabaseSubscription(request: request, subscriber: subscriber)
            subscriber.receive(subscription: subscription)
    }
}
