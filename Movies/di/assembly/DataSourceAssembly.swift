//
//  DataSourceAssembly.swift
//  Movies
//
//  Created by mustafa içmen on 28.02.2021.
//

import Foundation
import Swinject
import SwinjectAutoregistration

// provides Data Source instances for Dependency Injection
class DataSourceAssembly: Assembly {
    
    func assemble(container: Container) {
        
        // Movie
        container.autoregister(MovieDataSource.self, name: "local", initializer: MovieLocalDataSource.init)
        container.autoregister(MovieDataSource.self, name: "remote", initializer: MovieRemoteDataSource.init)
        
        // Person
        container.autoregister(PersonDataSource.self, name: "local", initializer: PersonLocalDataSource.init)
        container.autoregister(PersonDataSource.self, name: "remote", initializer: PersonRemoteDataSource.init)
    }
}
