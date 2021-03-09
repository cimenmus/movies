//
//  NetworkBoundSubscription.swift
//  Movies
//
//  Created by mustafa içmen on 9.03.2021.
//

import Foundation
import Combine

class NetworkBoundSubscription<S: Subscriber, ResultType>: Subscription where S.Input == ResultType, S.Failure == Error {
    
    private var loadFromNetwork: () -> AnyPublisher<ResultType, AppError>
    private var loadFromDb: () -> AnyPublisher<ResultType, AppError>
    private var saveToDb: (ResultType) -> Void
    private var subscriber: S?
    private var cancellableSet: Set<AnyCancellable>
    
    init(loadFromNetwork: @escaping () -> AnyPublisher<ResultType, AppError>,
         loadFromDb: @escaping () -> AnyPublisher<ResultType, AppError>,
         saveToDb: @escaping (ResultType) -> Void,
         subscriber: S,
         cancellableSet: Set<AnyCancellable>) {
        self.loadFromNetwork = loadFromNetwork
        self.loadFromDb = loadFromDb
        self.saveToDb = saveToDb
        self.subscriber = subscriber
        self.cancellableSet = cancellableSet
        sendRequest()
    }
    
    func request(_ demand: Subscribers.Demand) {
        //TODO: - Optionaly Adjust The Demand
    }
    
    func cancel() {
        subscriber = nil
    }
    
    private func sendRequest() {
        guard let subscriber = subscriber else { return }
        
        loadFromNetwork()
            .sink(
                receiveCompletion: { completion in
                    switch completion {
                        case .failure(let error):
                            self.observeDb(networkError: error)
                        case .finished:
                            print("")
                    }
                },
                receiveValue: { value in
                    self.saveToDb(value)
                    let _ = subscriber.receive(value)
                }).store(in: &cancellableSet)
    }
    
    private func observeDb(networkError: AppError){
        guard let subscriber = subscriber else { return }
        loadFromDb()
            .sink(
                receiveCompletion: { completion in
                    switch completion {
                        case .failure(let dbError):
                            subscriber.receive(completion: Subscribers.Completion.failure(networkError))
                        case .finished:
                            print("")
                    }
                },
                receiveValue: { value in
                    self.saveToDb(value)
                    let _ = subscriber.receive(value)
                })
            .store(in: &cancellableSet)
    }
}
