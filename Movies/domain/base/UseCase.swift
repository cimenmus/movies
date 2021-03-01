//
//  UseCase.swift
//  Movies
//
//  Created by mustafa içmen on 1.03.2021.
//

import Foundation

protocol UseCase {
   
    associatedtype P
    associatedtype R
    
    func execute(parameters: P) -> R
}

extension UseCase {
    
    func invoke(parameters: P) -> Result<R> {
        do {
            let response = try execute(parameters: parameters)
            return Result.success(data: response)
            //try return Result.success(data: execute(parameters: parameters))
        } catch {
            let error = AppError(type: AppError.ErrorType.USECASE, message: "Uxecpected usecase error")
            return Result.error(error: error)
        }
    }
}
