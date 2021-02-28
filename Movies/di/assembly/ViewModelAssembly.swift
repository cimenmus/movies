//
//  ViewModelAssembly.swift
//  Movies
//
//  Created by mustafa içmen on 28.02.2021.
//

import Foundation
import Swinject
import SwinjectAutoregistration

// provides View Model instances for Dependency Injection
class ViewModelAssembly: Assembly {
    
    func assemble(container: Container) {
        container.autoregister(PopularMoviesViewModel.self, initializer: PopularMoviesViewModel.init)
        container.autoregister(MovieDetailsViewModel.self, initializer: MovieDetailsViewModel.init)
        container.autoregister(PersonDetailsViewModel.self, initializer: PersonDetailsViewModel.init)
    }
}
