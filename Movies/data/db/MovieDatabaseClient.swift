//
//  MovieDatabaseClient.swift
//  Movies
//
//  Created by mustafa içmen on 28.02.2021.
//

import Foundation
import RxSwift

// makes Movie Database operations like read and insert
class MovieDatabaseClient {
    
    func getPopularMovies(page: Int) -> Single<[MovieModel]> {
        return Single<[MovieModel]>.create { single in
            let error = AppError(type: ErrorType.DB_ITEM_NOT_FOUND, message: "Database is not implemented yet.")
            single(.failure(error))
            return Disposables.create {
                
            }
        }
    }
    
    // Database is not implemented yet
    func getCastOfMovie(movieId: Int) -> Single<[MovieCastModel]> {
        return Single<[MovieCastModel]>.create { single in
            let error = AppError(type: ErrorType.DB_ITEM_NOT_FOUND, message: "Database is not implemented yet.")
            single(.failure(error))
            return Disposables.create {
                
            }
        }
    }
    
    func saveMovies(movies: [MovieModel]) {
        
    }
    
    func saveMovieCast(movieId: Int, movieCast: [MovieCastModel]) {
        
    }
}
