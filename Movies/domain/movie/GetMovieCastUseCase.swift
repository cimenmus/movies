//
//  GetMovieCastUseCase.swift
//  Movies
//
//  Created by mustafa içmen on 1.03.2021.
//

import Foundation
import RxSwift

class GetMovieCastUseCase: RxSubjectUseCase {
    
    typealias P = MovieCastParameter
    typealias R = [MovieCastModel]
    
    // dependencies are injected by Dependency Injetion
    private let movieRepository: MovieRepository!
    
    init(movieRepository: MovieRepository) {
        self.movieRepository = movieRepository
    }
    
    func execute(parameters: MovieCastParameter) -> Single<[MovieCastModel]> {
        return movieRepository.getCastOfMovie(movieId: parameters.movieId)
    }
    
}

struct MovieCastParameter {
    var movieId : Int
}

