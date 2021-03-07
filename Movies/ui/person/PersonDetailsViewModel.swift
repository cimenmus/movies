//
//  PersonDetailsViewModel.swift
//  Movies
//
//  Created by mustafa içmen on 28.02.2021.
//

import Foundation
import Combine

struct PersonDetailsViewModel {
        
    // dependencies are injected by Dependency Injetion
    private let getPersonDetailsUseCase: GetPersonDetailsUseCase!
        
    init(getPersonDetailsUseCase: GetPersonDetailsUseCase) {
        self.getPersonDetailsUseCase = getPersonDetailsUseCase
    }
    
    func getPersonDetails(personId: Int) -> AnyPublisher<PersonModel, AppError> {
        return getPersonDetailsUseCase.invoke(parameters: PersonDetailParameter(personId: personId))
    }
}
