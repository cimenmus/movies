//
//  MovieLocalDataSource.swift
//  Movies
//
//  Created by mustafa içmen on 28.02.2021.
//

import Foundation
import RxSwift

// makes Movie data operations on database using MovieDatabaseClient
struct MovieLocalDataSource: MovieDataSource {
    
    let databaseClient: MovieDatabaseClient!
    
    init(databaseClient: MovieDatabaseClient) {
        self.databaseClient = databaseClient
    }
    
    func getPopularMovies(page: Int) -> Single<[MovieModel]> {
        self.databaseClient.getPopularMovies(page: page)
    }
    
    func saveMovies(movies: [MovieModel]) {
        self.databaseClient.saveMovies(movies: movies)
    }
    
    func getCastOfMovie(movieId: Int) -> Single<[MovieCastModel]> {
        self.databaseClient.getCastOfMovie(movieId: movieId)
    }
    
    func saveMovieCast(movieId: Int, movieCast: [MovieCastModel]) {
        self.databaseClient.saveMovieCast(movieId: movieId, movieCast: movieCast)
    }
    
}
