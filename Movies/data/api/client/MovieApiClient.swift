//
//  MovieApiClient.swift
//  Movies
//
//  Created by mustafa içmen on 28.02.2021.
//

import Foundation
import Alamofire
import RxSwift

class MovieApiClient {

    func getPopularMovies(page: Int) -> Single<[MovieModel]> {
        return NetworkResource<PopularMoviesApiResponse, [MovieModel]>(
            networkRequest: ApiRouter.getPopularMovies(page: page),
            responseParser: { response in return response.results ?? [MovieModel]()}
        ).execute()
    }
    
    func getCastOfMovie(movieId: Int) -> Single<[MovieCastModel]> {
        return NetworkResource<MovieCastApiResponse, [MovieCastModel]>(
            networkRequest: ApiRouter.getCastOfAMovie(movieId: movieId),
            responseParser: { response in return response.cast ?? [MovieCastModel]()}
        ).execute()
    }
    
}
