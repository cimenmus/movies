//
//  PersonDataSource.swift
//  Movies
//
//  Created by mustafa içmen on 28.02.2021.
//

import Foundation

import Combine

protocol PersonDataSource {
    
    func getPersonDetails(personId: Int) -> AnyPublisher<PersonModel, AppError>
    
    func savePerson(person: PersonModel)
}
