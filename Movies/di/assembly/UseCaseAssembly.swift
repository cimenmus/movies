//
//  UseCaseAssembly.swift
//  Movies
//
//  Created by mustafa içmen on 28.02.2021.
//

import Foundation
import Swinject
import SwinjectAutoregistration

// provides UseCase instances for Dependency Injection
class UseCaseAssembly: Assembly {
    
    func assemble(container: Container) {
        
        // Movie
        container.autoregister(GetPopularMoviesUseCase.self, initializer: GetPopularMoviesUseCase.init)
        container.autoregister(GetMovieCastUseCase.self, initializer: GetMovieCastUseCase.init)
        
        // Person
        container.autoregister(GetPersonDetailsUseCase.self, initializer: GetPersonDetailsUseCase.init)
        
    }
}
