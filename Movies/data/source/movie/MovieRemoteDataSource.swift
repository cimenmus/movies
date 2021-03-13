//
//  MovieRemoteDataSource.swift
//  Movies
//
//  Created by mustafa içmen on 28.02.2021.
//

import Foundation
import Combine

class MovieRemoteDataSource: MovieDataSource {
    
    var urlSession: URLSession!
    
    // will be called by Dependency Injection
    init(urlSession: URLSession) {
        self.urlSession = urlSession
    }
    
    func getPopularMovies(page: Int) -> AnyPublisher<[MovieModel], AppError> {
        let request = ApiRouter.getPopularMovies(page: page).asUrlRequest()
        return NetworkResult<PopularMoviesApiResponse, [MovieModel]>(
            urlSession: urlSession,
            responseParser: { response in return response.results ?? [MovieModel]()}
        ).execute(urlRequest: request)
    }
    
    func saveMovies(movies: [MovieModel]) {}
    
    func getCastOfMovie(movieId: Int) -> AnyPublisher<[MovieCastModel], AppError> {
        let request = ApiRouter.getCastOfAMovie(movieId: movieId).asUrlRequest()
        return NetworkResult<MovieCastApiResponse, [MovieCastModel]>(
            urlSession: urlSession,
            responseParser: { response in return response.cast ?? [MovieCastModel]()}
        ).execute(urlRequest: request)
    }
        
    func saveMovieCast(movieId: Int, movieCast: [MovieCastModel]) {}
    
}
