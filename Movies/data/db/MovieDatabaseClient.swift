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
        return DatabaseResource<[MovieModel]>(
            dbRequest: { return nil }
        ).execute()
    }
    
    // Database is not implemented yet
    func getCastOfMovie(movieId: Int) -> Single<[MovieCastModel]> {
        return DatabaseResource<[MovieCastModel]>(
            dbRequest: { return nil }
        ).execute()
    }
    
    func saveMovies(movies: [MovieModel]) {
        
    }
    
    func saveMovieCast(movieId: Int, movieCast: [MovieCastModel]) {
        
    }
}
