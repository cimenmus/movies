//
//  MovieRemoteDataSourceTest.swift
//  MoviesTests
//
//  Created by mustafa içmen on 10.03.2021.
//

import Foundation
import XCTest
import Mockit
import Combine
@testable import Movies

class MovieRemoteDataSourceTest: XCTestCase {

    var movieRemoteDataSource: MockMovieRemoteDataSource!
    var expectation: XCTestExpectation!
    var cancellableSet: Set<AnyCancellable> = []
    
    override func setUp() {
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [MockURLProtocol.self]
        movieRemoteDataSource = MockMovieRemoteDataSource(urlSession: getUrlSession(), testCase: self)
        expectation = expectation(description: "Expectation")
    }
    
    
    func testCheckNetworkUtilsShouldReturnFalse() {
        
        // Given
        let movie1 = MovieModel(
            id: 1,
            adult: true,
            posterImagePath: "poster_path_1",
            backdropImagePath: "backdrop_path_1",
            title: "title_1",
            overview: "overview_1",
            average: 2,
            voteCount: 1,
            releaseDate: "release_date_1",
            popularity: 1)
        let movie2 = MovieModel(
            id: 2,
            adult: false,
            posterImagePath: "poster_path_2",
            backdropImagePath: "backdrop_path_2",
            title: "title_2",
            overview: "overview_2",
            average: 2,
            voteCount: 2,
            releaseDate: "release_date_2",
            popularity: 2)
        var movies:[MovieModel] = [movie1, movie2]
        let p = Publishers.
        let _ = movieRemoteDataSource.when().call(withReturnValue: movieRemoteDataSource.getPopularMovies(page: 1)).thenReturn(<#T##values: AnyPublisher<[MovieModel], AppError>?...##AnyPublisher<[MovieModel], AppError>?#>)
        
        // When
        movieRemoteDataSource.getPopularMovies(page: 1).sink(
            receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    print("failure")
                case .finished:
                    print("finished")
                }
              },
            receiveValue: { value in
                guard value.count == movies.count else {
                    XCTFail("Expected received value \(value) to match first expected value \(expectedValue)")
                    return
                }
            })
            .store(in: &cancellableSet)
        
            
        
        // Then
        let _ = networkUtils.verify(verificationMode: Once()).isNetworkAvailable()
        XCTAssertEqual(false, isNetworkAvailable)
        
    }
    
    /*
    func testCheckNetworkUtilsShouldReturnTrue() {
        
        // Given
        let _ = networkUtils.when().call(withReturnValue: networkUtils.isNetworkAvailable()).thenReturn(true)
        
        // When
        let isNetworkAvailable = networkUtils.isNetworkAvailable()
        
        // Then
        let _ = networkUtils.verify(verificationMode: Once()).isNetworkAvailable()
        XCTAssertEqual(true, isNetworkAvailable)
        
    }
    */
    
    private func getUrlSession() -> URLSession{
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [MockURLProtocol.self]
        return URLSession.init(configuration: configuration)
    }

}
