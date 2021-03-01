//
//  GetPopularMoviesUseCase.swift
//  Movies
//
//  Created by mustafa içmen on 1.03.2021.
//

import Foundation
import RxSwift

class GetPopularMoviesUseCase: RxUseCase {
    
    typealias P = PopularMoviesParameter
    typealias R = [MovieModel]
    
    // dependencies are injected by Dependency Injetion
    private let movieRepository: MovieRepository!
    
    init(movieRepository: MovieRepository) {
        self.movieRepository = movieRepository
    }
    
    func execute(parameters: PopularMoviesParameter) -> Single<[MovieModel]> {
        return movieRepository.getPopularMovies(page: parameters.page)
    }
    
}

struct PopularMoviesParameter {
    var page : Int
}
