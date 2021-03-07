//
//  PersonRepository.swift
//  Movies
//
//  Created by mustafa içmen on 28.02.2021.
//

import Foundation
import Combine

// decides which data source is used to fetch Search data
protocol PersonRepository {
    
    func getPersonDetails(personId: Int) -> AnyPublisher<PersonModel, AppError>
    
    func savePerson(person: PersonModel)
}
