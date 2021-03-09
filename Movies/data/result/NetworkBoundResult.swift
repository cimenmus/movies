//
//  NetworkBoundResult.swift
//  Movies
//
//  Created by mustafa içmen on 6.03.2021.
//

import Foundation
import Combine

class NetworkBoundResult<ResultType> {
            
    private var loadFromNetwork: () -> AnyPublisher<ResultType, AppError>
    private var loadFromDb: () -> AnyPublisher<ResultType, AppError>
    private var saveToDb: (ResultType) -> Void
    private var cancellableSet: Set<AnyCancellable> = []
    
    init(loadFromNetwork: @escaping () -> AnyPublisher<ResultType, AppError>,
         loadFromDb: @escaping () -> AnyPublisher<ResultType, AppError>,
         saveToDb: @escaping (ResultType) -> Void,
         cancellableSet: Set<AnyCancellable>) {
        self.loadFromNetwork = loadFromNetwork
        self.loadFromDb = loadFromDb
        self.saveToDb = saveToDb
        self.cancellableSet = cancellableSet
    }
    
    func execute<ResultType>() -> AnyPublisher<ResultType, AppError> {
        return NetworkBoundPublisher(loadFromNetwork: loadFromNetwork,
                                     loadFromDb: loadFromDb,
                                     saveToDb: saveToDb,
                                     cancellableSet: cancellableSet)
            .mapError { err in err as! AppError }
            .print()
            .flatMap { data -> AnyPublisher<ResultType, AppError> in
                if (data is Array<AnyObject> && (data as! Array<AnyObject>).isEmpty) {
                    let error = AppError(type: AppError.ErrorType.UNKNOWN, message: "Unknown error")
                    return .fail(error)
                } else {
                    return .just(data as! ResultType)
                }
                
            }
            .eraseToAnyPublisher()
   }
    
}
