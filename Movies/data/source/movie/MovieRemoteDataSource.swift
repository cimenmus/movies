//
//  MovieRemoteDataSource.swift
//  Movies
//
//  Created by mustafa içmen on 28.02.2021.
//

import Foundation
import RxSwift

struct MovieRemoteDataSource: MovieDataSource {
    
    func getPopularMovies(page: Int) -> Single<[MovieModel]> {
        return NetworkResult<PopularMoviesApiResponse, [MovieModel]>(
            networkRequest: ApiRouter.getPopularMovies(page: page),
            responseParser: { response in return response.results ?? [MovieModel]()}
        ).execute()
    }
    
    func saveMovies(movies: [MovieModel]) {}
    
    func getCastOfMovie(movieId: Int) -> Single<[MovieCastModel]> {
        return NetworkResult<MovieCastApiResponse, [MovieCastModel]>(
            networkRequest: ApiRouter.getCastOfAMovie(movieId: movieId),
            responseParser: { response in return response.cast ?? [MovieCastModel]()}
        ).execute()
    }
    
    func saveMovieCast(movieId: Int, movieCast: [MovieCastModel]) {}
    
}
