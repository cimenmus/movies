//
//  PersonRemoteDataSource.swift
//  Movies
//
//  Created by mustafa içmen on 28.02.2021.
//

import Foundation
import Combine

struct PersonRemoteDataSource: PersonDataSource {
    
    let urlSession: URLSession!
    
    // will be called by Dependency Injection
    init(urlSession: URLSession) {
        self.urlSession = urlSession
    }
    
    func getPersonDetails(personId: Int) -> AnyPublisher<PersonModel, AppError> {
        let request = ApiRouter.getPersonDetail(personId: personId).asUrlRequest()
        return NetworkResult<PersonModel, PersonModel>(
            urlSession: urlSession
        ).execute(urlRequest: request)
    }
    
    func savePerson(person: PersonModel) {}
}
