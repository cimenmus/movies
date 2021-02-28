//
//  RepositoryAssembly.swift
//  Movies
//
//  Created by mustafa içmen on 28.02.2021.
//

import Foundation
import Swinject
import SwinjectAutoregistration

// provides Repository instances for Dependency Injection
class RepositoryAssembly: Assembly {
    
    func assemble(container: Container) {
        
        // Movie
        container.register(MovieRepository.self, factory: { resolver in
            return MovieRepositoryImpl(networkUtils: resolver~>,
                                       movieLocalDataSource: resolver ~> (MovieDataSource.self, name: "local"),
                                       movieRemoteDataSource: resolver ~> (MovieDataSource.self, name: "remote"))
        })
        
        // Person
        container.register(PersonRepository.self, factory: { resolver in
            return PersonRepositoryImpl(networkUtils: resolver~>,
                                        personLocalDataSource: resolver ~> (PersonDataSource.self, name: "local"),
                                        personRemoteDataSource: resolver ~> (PersonDataSource.self, name: "remote"))
        })
    }
}
