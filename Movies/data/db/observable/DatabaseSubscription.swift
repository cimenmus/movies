//
//  DatabaseSubscription.swift
//  Movies
//
//  Created by mustafa içmen on 9.03.2021.
//

import Foundation
import Combine

class DatabaseSubscription<S: Subscriber, ResultType>: Subscription where S.Input == ResultType, S.Failure == Error {
    
    private var request: (() -> ResultType?)
    private var subscriber: S?
    
    init(request: @escaping (() -> ResultType?), subscriber: S) {
        self.request = request
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
        let result = request()
        if result == nil || (result is Array<AnyObject> && (result as! Array<AnyObject>).isEmpty) {
            let error = AppError(type: AppError.ErrorType.DB_ITEM_NOT_FOUND, message: "Database item not found.")
            subscriber.receive(completion: Subscribers.Completion.failure(error))
        } else {
            let _ = subscriber.receive(result!)
        }
    }
}
