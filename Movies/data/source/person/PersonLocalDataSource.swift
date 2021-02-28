//
//  PersonLocalDataSource.swift
//  Movies
//
//  Created by mustafa içmen on 28.02.2021.
//

import Foundation
import RxSwift

// makes Person data operations on database using PersonDatabaseClient
struct PersonLocalDataSource: PersonDataSource {
    
    let databaseClient: PersonDatabaseClient!
    
    init(databaseClient: PersonDatabaseClient) {
        self.databaseClient = databaseClient
    }
    
    func getPersonDetails(personId: Int) -> Single<PersonModel> {
        return databaseClient.getPersonDetails(personId: personId)
    }
    
    func savePerson(person: PersonModel) {
        databaseClient.savePerson(person: person)
    }
}
