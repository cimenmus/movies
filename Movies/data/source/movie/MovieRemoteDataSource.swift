//
//  MovieRemoteDataSource.swift
//  Movies
//
//  Created by mustafa içmen on 28.02.2021.
//

import Foundation
import RxSwift

// makes Movie data operations on API using MovieApiClient
struct MovieRemoteDataSource: MovieDataSource {
    
    let apiClient: MovieApiClient!
    
    init(apiClient: MovieApiClient) {
        self.apiClient = apiClient
    }
    
    func getPopularMovies(page: Int) -> Single<[MovieModel]> {
        return apiClient.getPopularMovies(page: page)
    }
    
    func saveMovies(movies: [MovieModel]) {}
    
    func getCastOfMovie(movieId: Int) -> Single<[MovieCastModel]> {
        return apiClient.getCastOfMovie(movieId: movieId)
    }
    
    func saveMovieCast(movieId: Int, movieCast: [MovieCastModel]) {}
    
    
}
