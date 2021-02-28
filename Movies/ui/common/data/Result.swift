//
//  Result.swift
//  Movies
//
//  Created by mustafa içmen on 28.02.2021.
//

import Foundation

// to make view controller avare of state of an operation and send operation data or error
struct Result<T> {
    
    let state: State
    let data: T?
    var error: AppError?
    
    private init(state: State,
                 data: T? = nil,
                 error: AppError? = nil) {
        self.state = state
        self.data = data
        self.error = error
    }
    
    static func loading(data: T? = nil) -> Result<T> {
        return Result(state: State.LOADING, data: data)
    }
    
    static func success(data: T? = nil) -> Result<T> {
        return Result(state: State.SUCCESS, data: data)
    }
    
    static func error(error: AppError, data: T? = nil) -> Result<T> {
        return Result(state: State.ERROR, data: data, error: error)
    }
    
    // to make view controller avare of state of an operation
    enum State {
        case LOADING
        case SUCCESS
        case ERROR
    }
    
}
