//
//  DatabaseAssembly.swift
//  Movies
//
//  Created by mustafa içmen on 28.02.2021.
//

import Foundation
import Swinject
import SwinjectAutoregistration

// provides Database Client instances for Dependency Injection
class DatabaseAssembly: Assembly {
    
    func assemble(container: Container) {
        
        // Movie
        container.autoregister(MovieDatabaseClient.self, initializer: MovieDatabaseClient.init)
        
        // Person
        container.autoregister(PersonDatabaseClient.self, initializer: PersonDatabaseClient.init)
    }
    
}
