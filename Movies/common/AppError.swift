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
}

extension Error {
    
    func toAppError() -> AppError {
        if let appError = self as? AppError {
            return appError
        } else {
            return AppError(type: ErrorType.UNKNOWN, message: "An error has occured")
        }
    }
}
