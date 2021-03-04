//
//  DependencyManager.swift
//  Movies
//
//  Created by mustafa içmen on 28.02.2021.
//

import Foundation
import Swinject
import RxSwift

// adds Assemblers to Dependency Injection
class DependencyManager {
    
    static let shared = DependencyManager()
    
    private let assembler = Assembler([
        DataSourceAssembly(),
        DisposableAssembly(),
        RepositoryAssembly(),
        ViewControllerAssembly(),
        ViewModelAssembly(),
        UtilsAssembly(),
        UseCaseAssembly()
    ])
    
    private init() {}
    
    func resolve<T>(type: T.Type) -> T {
        return assembler.resolver.resolve(type)!
    }
    
}
