//
//  UtilsAssembly.swift
//  Movies
//
//  Created by mustafa içmen on 28.02.2021.
//

import Foundation
import Swinject
import SwinjectAutoregistration

// provides Utils instances for Dependency Injection
class UtilsAssembly: Assembly {
    
     func assemble(container: Container) {
        
        container.autoregister(NetworkUtils.self, initializer: NetworkUtils.init)
        container.autoregister(DialogUtils.self, initializer: DialogUtils.init)
     }
}
