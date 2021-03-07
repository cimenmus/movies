//
//  MovieDetailsViewModel.swift
//  Movies
//
//  Created by mustafa içmen on 28.02.2021.
//

import Foundation
import Combine

class MovieDetailsViewModel {
    
    // dependencies are injected by Dependency Injetion
    private let getMovieCastUseCase: GetMovieCastUseCase!
    
    // will be called by Dependency Injection
    init(getMovieCastUseCase: GetMovieCastUseCase) {
        self.getMovieCastUseCase = getMovieCastUseCase
    }
    
    func getCastOfMovie(movieId: Int) -> AnyPublisher<[MovieCastModel], AppError> {
        return getMovieCastUseCase.invoke(parameters: MovieCastParameter(movieId: movieId))
    }
    
}

