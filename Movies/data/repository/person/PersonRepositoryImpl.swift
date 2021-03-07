//
//  PersonRepositoryImpl.swift
//  Movies
//
//  Created by mustafa içmen on 28.02.2021.
//

import Foundation
import Combine

// decides which data source is used to fetch Search data
class PersonRepositoryImpl: PersonRepository {
    
    // dependencies are injected by Dependency Injetion
    let networkUtils: NetworkUtils!
    let personRemoteDataSource: PersonDataSource!
    let personLocalDataSource: PersonDataSource!
    
    // will be called by Dependency Injection
    init(networkUtils: NetworkUtils,
         personLocalDataSource: PersonDataSource,
         personRemoteDataSource: PersonDataSource) {
        self.networkUtils = networkUtils
        self.personRemoteDataSource = personRemoteDataSource
        self.personLocalDataSource = personLocalDataSource
    }
    
    /**
     take 3 closure parameters to fetch data from network, insert data to database and fetch data from database
     first tries to fetch data from network
     if fetching network succeed, the fetched data will be inserted into database, then data is returned
     if network is not available, the data will be fetched from database and then returned
     */
    func getPersonDetails(personId: Int) -> AnyPublisher<PersonModel, AppError> {
        return self.personRemoteDataSource.getPersonDetails(personId: personId)
        /*
        return NetworkBoundResult<PersonModel>(
            loadFromNetwork: { self.personRemoteDataSource.getPersonDetails(personId: personId) },
            loadFromDb: { self.personLocalDataSource.getPersonDetails(personId: personId) },
            saveToDb: { data in self.personLocalDataSource.savePerson(person: data)}
        ).execute()
        */
    }
    
    func savePerson(person: PersonModel) {
        personLocalDataSource.savePerson(person: person)
    }
}
