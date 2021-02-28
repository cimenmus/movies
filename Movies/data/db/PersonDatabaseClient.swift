//
//  PersonDatabaseClient.swift
//  Movies
//
//  Created by mustafa içmen on 28.02.2021.
//

import Foundation
import RxSwift

// makes Person Database operations like read and insert
class PersonDatabaseClient {
        
    // Database is not implemented yet
    func getPersonDetails(personId: Int) -> Single<PersonModel> {
        return Single<PersonModel>.create { single in
            let error = AppError(type: ErrorType.DB_ITEM_NOT_FOUND, message: "Database is not implemented yet.")
            single(.failure(error))
            return Disposables.create {
                
            }
        }
    }
    
    func savePerson(person: PersonModel) {
        
    }
}
