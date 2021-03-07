//
//  GetPopularMoviesUseCase.swift
//  Movies
//
//  Created by mustafa içmen on 1.03.2021.
//

import Foundation
import Combine

class GetPopularMoviesUseCase: CombineUseCase {

    typealias P = PopularMoviesParameter
    typealias R = [MovieModel]
    
    // dependencies are injected by Dependency Injetion
    private let movieRepository: MovieRepository!
    
    init(movieRepository: MovieRepository) {
        self.movieRepository = movieRepository
    }
    
    func execute(parameters: PopularMoviesParameter) -> AnyPublisher<[MovieModel], AppError> {
        return movieRepository.getPopularMovies(page: parameters.page)
    }
    
}

struct PopularMoviesParameter {
    var page : Int
}
