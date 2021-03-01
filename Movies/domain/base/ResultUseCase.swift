//
//  ResultUseCase.swift
//  Movies
//
//  Created by mustafa içmen on 1.03.2021.
//

import Foundation

protocol ResultUseCase {
   
    associatedtype P
    associatedtype R
    
    func execute(parameters: P) -> Result<R>
}

extension ResultUseCase {
    
    func invoke(parameters: P) -> Result<R> {
        do {
            let response = try execute(parameters: parameters)
            return response
            //try return Result.success(data: execute(parameters: parameters))
        } catch {
            let error = AppError(type: AppError.ErrorType.USECASE, message: "Uxecpected usecase error")
            return Result.error(error: error)
        }
    }
    
}
