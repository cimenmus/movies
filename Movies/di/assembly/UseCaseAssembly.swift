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
        
        //container.autoregister(PersonDetailViewModel.self, initializer: PersonDetailViewModel.init)
    }
}
