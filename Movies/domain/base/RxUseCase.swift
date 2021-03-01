//
//  RxUseCase.swift
//  Movies
//
//  Created by mustafa içmen on 1.03.2021.
//

import Foundation
import RxSwift

protocol RxUseCase {
   
    associatedtype P
    associatedtype R
    
    func execute(parameters: P) -> Single<R>
}

extension RxUseCase {
    func invoke(parameters: P) -> Single<R> {
        return execute(parameters: parameters)
    }
}
