//
//  MovieApiClient.swift
//  Movies
//
//  Created by mustafa içmen on 28.02.2021.
//

import Foundation
import Alamofire
import RxSwift

class MovieApiClient: BaseApiClient {

    // uses "request" method inside BaseApiClient to fetch popular movies data from API
    func getPopularMovies(page: Int) -> Single<[MovieModel]> {
        return request(ApiRouter.getPopularMovies(page: page))
    }
    
    // uses "request" method inside BaseApiClient to fetch movie details data from API
    func getCastOfMovie(movieId: Int) -> Single<[MovieCastModel]> {
        return request(ApiRouter.getCastOfAMovie(movieId: movieId))
    }
    
}
