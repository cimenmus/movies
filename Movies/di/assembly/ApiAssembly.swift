//
//  ApiAssembly.swift
//  Movies
//
//  Created by mustafa içmen on 10.03.2021.
//

import Foundation
import Swinject
import SwinjectAutoregistration

// provides Repository instances for Dependency Injection
class ApiAssembly: Assembly {
    
    func assemble(container: Container) {
        
        container.register(URLSession.self, factory: { resolver in
            let config = URLSessionConfiguration.default
            config.requestCachePolicy = .reloadIgnoringLocalCacheData
            config.urlCache = nil
            return URLSession.init(configuration: config)
        })
    }
}
