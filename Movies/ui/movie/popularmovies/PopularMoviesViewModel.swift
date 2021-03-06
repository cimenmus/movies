//
//  PopularMoviesViewModel.swift
//  Movies
//
//  Created by mustafa içmen on 28.02.2021.
//

import Foundation
import RxSwift

class PopularMoviesViewModel {
    
    // dependencies are injected by Dependency Injetion
    private let getPopularMoviesUseCase: GetPopularMoviesUseCase!
    private let disposeBag: DisposeBag! // to dispose observable on view model instance is remove from memory
        
    let popularMoviesObservable = PublishSubject<Result<[MovieModel]>>()
    private var currentPage = 0
    
    // will be called by Dependency Injection
    init(getPopularMoviesUseCase: GetPopularMoviesUseCase,
         disposeBag: DisposeBag) {
        self.getPopularMoviesUseCase = getPopularMoviesUseCase
        self.disposeBag = disposeBag
    }
    
    func getNextPopularMovies(showLoading: Bool = false) {
        if showLoading {
            popularMoviesObservable.onNext(Result.loading())
        }
        let nextPage = currentPage + 1
        getPopularMoviesUseCase.invoke(parameters: PopularMoviesParameter(page: nextPage),
                                       showLoading: showLoading,
                                       subject: popularMoviesObservable,
                                       disposeBag: disposeBag,
                                       onSuccess: {[weak self] data in self?.currentPage += 1} )
            
    }
    
}

