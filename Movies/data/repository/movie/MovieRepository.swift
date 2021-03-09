//
//  MovieRepository.swift
//  Movies
//
//  Created by mustafa içmen on 28.02.2021.
//

import Foundation
import Combine

// decides which data source is used to fetch Search data
protocol MovieRepository {
    
    func getPopularMovies(page: Int) -> AnyPublisher<[MovieModel], AppError>
    
    func saveMovies(movies: [MovieModel])
    
    func getCastOfMovie(movieId: Int) -> AnyPublisher<[MovieCastModel], AppError>
    
    func saveMovieCast(movieId: Int, movieCast: [MovieCastModel])
}
