//
//  GetPersonDetailsUseCase.swift
//  Movies
//
//  Created by mustafa içmen on 1.03.2021.
//

import Foundation
import RxSwift

class GetPersonDetailsUseCase: RxUseCase {
    
    typealias P = PersonDetailParameter
    typealias R = PersonModel
    
    // dependencies are injected by Dependency Injetion
    private let personRepository: PersonRepository!
    
    init(personRepository: PersonRepository) {
        self.personRepository = personRepository
    }
    
    func execute(parameters: PersonDetailParameter) -> Single<PersonModel> {
        return personRepository.getPersonDetails(personId: parameters.personId)
    }
    
}

struct PersonDetailParameter {
    var personId : Int
}
