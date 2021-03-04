//
//  MovieLocalDataSource.swift
//  Movies
//
//  Created by mustafa içmen on 28.02.2021.
//

import Foundation
import RxSwift

struct MovieLocalDataSource: MovieDataSource {
    
    func getPopularMovies(page: Int) -> Single<[MovieModel]> {
        return DatabaseResource<[MovieModel]>(
            dbRequest: { return nil }
        ).execute()
    }
    
    func saveMovies(movies: [MovieModel]) {
        
    }
    
    func getCastOfMovie(movieId: Int) -> Single<[MovieCastModel]> {
        return DatabaseResource<[MovieCastModel]>(
            dbRequest: { return nil }
        ).execute()
    }
    
    func saveMovieCast(movieId: Int, movieCast: [MovieCastModel]) {
        
    }
    
}
