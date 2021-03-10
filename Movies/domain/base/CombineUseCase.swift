//
//  CombineUseCase.swift
//  Movies
//
//  Created by mustafa içmen on 7.03.2021.
//

import Foundation
import Combine

protocol CombineUseCase {
   
    associatedtype P
    associatedtype R
    
    func execute(parameters: P) -> AnyPublisher<R, AppError>
}

extension CombineUseCase {
    
    func invoke(parameters: P,
                onSuccess: ((R) -> Void)? = nil,
                onError: ((AppError?) -> Void)? = nil) -> AnyPublisher<R, AppError> {
        return execute(parameters: parameters)
    }
    
    
}
