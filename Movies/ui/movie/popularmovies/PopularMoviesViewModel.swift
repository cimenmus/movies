//
//  PopularMoviesViewModel.swift
//  Movies
//
//  Created by mustafa içmen on 28.02.2021.
//

import Foundation
import Combine

class PopularMoviesViewModel {
    
    // dependencies are injected by Dependency Injetion
    private let getPopularMoviesUseCase: GetPopularMoviesUseCase!
        
    private var currentPage = 0
    
    // will be called by Dependency Injection
    init(getPopularMoviesUseCase: GetPopularMoviesUseCase) {
        self.getPopularMoviesUseCase = getPopularMoviesUseCase
    }
    
    func getNextPopularMovies() -> AnyPublisher<[MovieModel], AppError> {
        let nextPage = currentPage + 1
        return getPopularMoviesUseCase.invoke(
            parameters: PopularMoviesParameter(page: nextPage),
            onSuccess: {[weak self] data in self?.currentPage += 1})
    }
    
}

