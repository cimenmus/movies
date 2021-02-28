//
//  MovieDataSource.swift
//  Movies
//
//  Created by mustafa içmen on 28.02.2021.
//

import Foundation
import RxSwift

protocol MovieDataSource {
    
    func getPopularMovies(page: Int) -> Single<[MovieModel]>
    
    func saveMovies(movies: [MovieModel])
    
    func getCastOfMovie(movieId: Int) -> Single<[MovieCastModel]>
    
    func saveMovieCast(movieId: Int, movieCast: [MovieCastModel])
}
