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
        getPersonDetailsUseCase.invoke(parameters: PersonDetailParameter(personId: personId),
                                       subject: personDetailsObservable,
                                       disposeBag: disposeBag)
    }
}
