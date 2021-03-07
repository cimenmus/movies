//
//  PersonRemoteDataSource.swift
//  Movies
//
//  Created by mustafa içmen on 28.02.2021.
//

import Foundation
import Combine

struct PersonRemoteDataSource: PersonDataSource {
    
    func getPersonDetails(personId: Int) -> AnyPublisher<PersonModel, AppError> {
        let request = ApiRouter.getPersonDetail(personId: personId).asUrlRequest()
        return NetworkResult<PersonModel, PersonModel>().execute(urlRequest: request)
    }
    
    func savePerson(person: PersonModel) {}
}
