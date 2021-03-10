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
    
    init(loadFromNetwork: @escaping () -> AnyPublisher<ResultType, AppError>,
         loadFromDb: @escaping () -> AnyPublisher<ResultType, AppError>,
         saveToDb: @escaping (ResultType) -> Void,
         subscriber: S) {
        self.loadFromNetwork = loadFromNetwork
        self.loadFromDb = loadFromDb
        self.saveToDb = saveToDb
        self.subscriber = subscriber
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
        var networkCancelable: AnyCancellable?
        
        networkCancelable = loadFromNetwork()
            .sink(
                receiveCompletion: { completion in
                    switch completion {
                        case .failure(let error):
                            self.observeDb(networkCancelable: networkCancelable, networkError: error)
                        case .finished:
                            print("")
                            networkCancelable?.cancel()
                    }
                },
                receiveValue: { value in
                    self.saveToDb(value)
                    let _ = subscriber.receive(value)
                    networkCancelable?.cancel()
                })
    }
    
    private func observeDb(networkCancelable: AnyCancellable?, networkError: AppError){
        guard let subscriber = subscriber else { return }
        var dbCancelable: AnyCancellable?
        dbCancelable = loadFromDb()
            .sink(
                receiveCompletion: { completion in
                    switch completion {
                        case .failure(let dbError):
                            subscriber.receive(completion: Subscribers.Completion.failure(networkError))
                            networkCancelable?.cancel()
                            dbCancelable?.cancel()
                        case .finished:
                            print("")
                            networkCancelable?.cancel()
                            dbCancelable?.cancel()
                    }
                },
                receiveValue: { value in
                    self.saveToDb(value)
                    let _ = subscriber.receive(value)
                    networkCancelable?.cancel()
                    dbCancelable?.cancel()
                })
    }
}
