//
//  AppError.swift
//  Movies
//
//  Created by mustafa içmen on 28.02.2021.
//

import Foundation

// generic error model for whole application
struct AppError: LocalizedError {
    
    let type: ErrorType
    let message: String

    init(type: ErrorType, message: String) {
        self.type = type
        self.message = message
    }
    
    enum ErrorType: Int {
            
        case BAD_REQUEST = 400                        // Status code 400
        case UNAUTHORIZED = 401                       // Status code 401
        case FORBIDDEN = 403                          // Status code 403
        case NOT_FOUND = 404                         // Status code 404
        case INTERNAL_SERVER_ERROR = 500              // Status code 500
        
        case DB_ITEM_NOT_FOUND = 100
        case USECASE = 200
        case UNKNOWN = 0
    }
}

extension Error {
    
    func toAppError() -> AppError {
        if let appError = self as? AppError {
            return appError
        } else {
            return AppError(type: AppError.ErrorType.UNKNOWN, message: "An error has occured")
        }
    }
}

