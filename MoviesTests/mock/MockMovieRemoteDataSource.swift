//
//  MockMovieRemoteDataSource.swift
//  MoviesTests
//
//  Created by mustafa içmen on 10.03.2021.
//

import Foundation
import XCTest
import Mockit
import Combine
@testable import Movies

class MockMovieRemoteDataSource: MovieRemoteDataSource, Mock {
    
    var callHandler: CallHandler
    
    init(urlSession: URLSession, testCase: XCTestCase) {
        callHandler = CallHandlerImpl(withTestCase: testCase)
        super.init(urlSession: urlSession)
    }

    func instanceType() -> MockMovieRemoteDataSource {
        return self
    }
    
    override func getPopularMovies(page: Int) -> AnyPublisher<[MovieModel], AppError> {
        return callHandler.accept(false, ofFunction: #function, atFile: #file, inLine: #line, withArgs: nil) as! AnyPublisher<[MovieModel], AppError>
    }
    
    /*
    override func isNetworkAvailable() -> Bool {
        return callHandler.accept(false, ofFunction: #function, atFile: #file, inLine: #line, withArgs: nil) as! Bool
    }
    */
    
    private func getUrlSession() -> URLSession{
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [MockURLProtocol.self]
        return URLSession.init(configuration: configuration)
    }
    
}
