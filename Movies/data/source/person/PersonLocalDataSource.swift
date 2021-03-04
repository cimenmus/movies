//
//  PersonLocalDataSource.swift
//  Movies
//
//  Created by mustafa içmen on 28.02.2021.
//

import Foundation
import RxSwift

struct PersonLocalDataSource: PersonDataSource {
    
    func getPersonDetails(personId: Int) -> Single<PersonModel> {
        return DatabaseResource<PersonModel>(
            dbRequest: { return nil }
        ).execute()
    }
    
    func savePerson(person: PersonModel) {
        
    }
}
