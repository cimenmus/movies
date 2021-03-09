//
//  DatabaseResult.swift
//  Movies
//
//  Created by mustafa içmen on 6.03.2021.
//

import Foundation
import Combine
import RxSwift

class DatabaseResult<ResultType> {
            
    private var request: (() -> ResultType?)
    
    init(request: @escaping (() -> ResultType?)) {
        self.request = request
    }
            
    func execute<ResultType>() -> AnyPublisher<ResultType, AppError> {
        return DatabasePublisher(request: request)
            .mapError { err in err as! AppError }
            .print()
            .flatMap { data -> AnyPublisher<ResultType, AppError> in
                if (data is Array<AnyObject> && (data as! Array<AnyObject>).isEmpty) {
                    let error = AppError(type: AppError.ErrorType.DB_ITEM_NOT_FOUND, message: "Database item not found.")
                    return .fail(error)
                } else {
                    return .just(data as! ResultType)
                }
                
            }
            .eraseToAnyPublisher()
   } 
}
