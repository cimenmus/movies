//
//  PersonRemoteDataSource.swift
//  Movies
//
//  Created by mustafa içmen on 28.02.2021.
//

import Foundation
import RxSwift

// makes Person data operations on API using PersonApiClient
struct PersonRemoteDataSource: PersonDataSource {
    
    let apiClient: PersonApiClient!
    
    init(apiClient: PersonApiClient) {
        self.apiClient = apiClient
    }
    
    func getPersonDetails(personId: Int) -> Single<PersonModel> {
        return apiClient.getPersonDetails(personId: personId)
    }
    
    func savePerson(person: PersonModel) {}
}
