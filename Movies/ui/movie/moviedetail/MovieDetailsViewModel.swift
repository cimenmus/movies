//
//  MovieDetailsViewModel.swift
//  Movies
//
//  Created by mustafa içmen on 28.02.2021.
//

import Foundation
import RxSwift

class MovieDetailsViewModel {
    
    // dependencies are injected by Dependency Injetion
    private let getMovieCastUseCase: GetMovieCastUseCase!
    private let disposeBag: DisposeBag! // to dispose observable on view model instance is remove from memory
        
    let movieCastObservable = PublishSubject<Result<[MovieCastModel]>>()
    
    // will be called by Dependency Injection
    init(getMovieCastUseCase: GetMovieCastUseCase,
         disposeBag: DisposeBag) {
        self.getMovieCastUseCase = getMovieCastUseCase
        self.disposeBag = disposeBag
    }
    
    func getCastOfMovie(movieId: Int) {
        getMovieCastUseCase.invoke(parameters: MovieCastParameter(movieId: movieId),
                                   subject: movieCastObservable,
                                   disposeBag: disposeBag)
    }
    
}

