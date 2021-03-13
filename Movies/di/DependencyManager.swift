//
//  DependencyManager.swift
//  Movies
//
//  Created by mustafa içmen on 28.02.2021.
//

import Foundation
import Swinject

// adds Assemblers to Dependency Injection
class DependencyManager {
    
    static let shared = DependencyManager()
    
    private let assembler = Assembler([
        DataSourceAssembly(),
        RepositoryAssembly(),
        ViewControllerAssembly(),
        ViewModelAssembly(),
        UtilsAssembly(),
        UseCaseAssembly(),
        ApiAssembly()
    ])
    
    private init() {}
    
    func resolve<T>(type: T.Type) -> T {
        return assembler.resolver.resolve(type)!
    }
    
}
