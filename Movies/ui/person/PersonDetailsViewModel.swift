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
    private let personRepository: PersonRepository!
    private let disposeBag: DisposeBag!  // to dispose observable on view model instance is remove from memory
    
    let personDetailsObservable = PublishSubject<Result<PersonModel>>()
    
    // will be called by Dependency Injection
    init(personRepository: PersonRepository,
         disposeBag: DisposeBag) {
        self.personRepository = personRepository
        self.disposeBag = disposeBag
    }
    
    func getPersonDetails(personId: Int) {
        personDetailsObservable.onNext(Result.loading())
        personRepository
            .getPersonDetails(personId: personId)
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
