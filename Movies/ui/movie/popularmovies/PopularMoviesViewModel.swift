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
    private let movieRepository: MovieRepository!
    private let disposeBag: DisposeBag! // to dispose observable on view model instance is remove from memory
        
    let popularMoviesObservable = PublishSubject<Result<[MovieModel]>>()
    private var currentPage = 0
    
    // will be called by Dependency Injection
    init(movieRepository: MovieRepository,
         disposeBag: DisposeBag) {
        self.movieRepository = movieRepository
        self.disposeBag = disposeBag
    }
    
    func getNextPopularMovies(showLoading: Bool = false) {
        if showLoading {
            popularMoviesObservable.onNext(Result.loading())
        }
        let nextPage = currentPage + 1
        movieRepository.getPopularMovies(page: nextPage)
            .observeOn(MainScheduler.instance)
            .subscribe(
                onSuccess: { popularMovies in
                    self.popularMoviesObservable.onNext(Result.success(data: popularMovies))
                    self.currentPage += 1
                },
                onError: { error in
                    self.popularMoviesObservable.onNext(Result.error(error: error.toAppError()))
                }
            )
            .disposed(by: disposeBag)
    }
    
}

