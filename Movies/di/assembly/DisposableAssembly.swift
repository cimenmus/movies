//
//  DisposableAssembly.swift
//  Movies
//
//  Created by mustafa içmen on 28.02.2021.
//

import Foundation
import Swinject
import SwinjectAutoregistration
import RxSwift

// provides Disposable instances for Dependency Injection
class DisposableAssembly: Assembly {
    
    func assemble(container: Container) {
        container.register(DisposeBag.self, factory: { resolver in
            return DisposeBag()
        })
    }
}
