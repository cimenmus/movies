//
//  PersonRepository.swift
//  Movies
//
//  Created by mustafa içmen on 28.02.2021.
//

import Foundation
import RxSwift

// decides which data source is used to fetch Search data
protocol PersonRepository {
    
    func getPersonDetails(personId: Int) -> Single<PersonModel>
    
    func savePerson(person: PersonModel)
}
