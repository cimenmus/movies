//
//  ViewControllerAssembly.swift
//  Movies
//
//  Created by mustafa içmen on 28.02.2021.
//

import Foundation
import Swinject
import SwinjectAutoregistration

// provides View Controller instances for Dependency Injection
class ViewControllerAssembly: Assembly {
    
    func assemble(container: Container) {
        
        // PopularMoviesViewController
        container.register(PopularMoviesViewController.self, factory: { resolver in
            let vc = PopularMoviesViewController()
            vc.viewModel = resolver.resolve(PopularMoviesViewModel.self)
            vc.dialogUtils = resolver.resolve(DialogUtils.self)
            return vc
        })
        
        // MovieDetailsViewController
        container.register(MovieDetailsViewController.self, factory: { resolver in
            let vc = MovieDetailsViewController()
            vc.viewModel = resolver.resolve(MovieDetailsViewModel.self)
            vc.dialogUtils = resolver.resolve(DialogUtils.self)
            return vc
        })
        
        // PersonDetailsViewController
        container.register(PersonDetailsViewController.self, factory: { resolver in
            let vc = PersonDetailsViewController()
            vc.viewModel = resolver.resolve(PersonDetailsViewModel.self)
            vc.dialogUtils = resolver.resolve(DialogUtils.self)
            return vc
        })
        
    }
}
