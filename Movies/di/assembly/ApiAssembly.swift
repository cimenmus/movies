//
//  ApiAssembly.swift
//  Movies
//
//  Created by mustafa içmen on 28.02.2021.
//

import Foundation
import Swinject
import SwinjectAutoregistration

// provides Api Client instances for Dependency Injection
class ApiAssembly: Assembly {
    
    func assemble(container: Container) {
                
        // Movie
        container.autoregister(MovieApiClient.self, initializer: MovieApiClient.init)
        
        // Person
        container.autoregister(PersonApiClient.self, initializer: PersonApiClient.init)
    }
    
}
