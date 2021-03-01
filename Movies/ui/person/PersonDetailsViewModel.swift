//
//  PersonDetailsViewModel.swift
//  Movies
//
//  Created by mustafa içmen on 28.02.2021.
//

import Foundation
import RxSwift

struct PersonDetailsViewModel {
        
    // dependencies are injected by Dependency Injetion
    private let getPersonDetailsUseCase: GetPersonDetailsUseCase!
    private let disposeBag: DisposeBag!  // to dispose observable on view model instance is remove from memory
    
    let personDetailsObservable = PublishSubject<Result<PersonModel>>()
    
    init(getPersonDetailsUseCase: GetPersonDetailsUseCase,
         disposeBag: DisposeBag) {
        self.getPersonDetailsUseCase = getPersonDetailsUseCase
        self.disposeBag = disposeBag
    }
    
    func getPersonDetails(personId: Int) {
        personDetailsObservable.onNext(Result.loading())
        getPersonDetailsUseCase.invoke(parameters: PersonDetailParameter(personId: personId))
            .observeOn(MainScheduler.instance)
            .subscribe(
                onSuccess: { person in
                    personDetailsObservable.onNext(Result.success(data: person))
                },
                onError: { error in
                    personDetailsObservable.onNext(Result.error(error: error.toAppError()))
                }
            )
            .disposed(by: disposeBag)
    }
}
