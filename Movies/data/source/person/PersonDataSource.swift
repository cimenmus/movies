//
//  PersonDataSource.swift
//  Movies
//
//  Created by mustafa içmen on 28.02.2021.
//

import Foundation

import RxSwift

protocol PersonDataSource {
    
    func getPersonDetails(personId: Int) -> Single<PersonModel>
    
    func savePerson(person: PersonModel)
}
