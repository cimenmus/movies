//
//  NetworkUtilsMockingTest.swift
//  MoviesTests
//
//  Created by mustafa içmen on 6.03.2021.
//

import Foundation
import XCTest
import Mockit
@testable import Movies

class NetworkUtilsMockingTest: XCTestCase {

    var networkUtils: MockNetworkUtils!
    
    override func setUp() {
        networkUtils = MockNetworkUtils(testCase: self)
    }
    
    func testCheckNetworkUtilsShouldReturnFalse() {
        
        // Given
        let _ = networkUtils.when().call(withReturnValue: networkUtils.isNetworkAvailable()).thenReturn(false)
        
        // When
        let isNetworkAvailable = networkUtils.isNetworkAvailable()
        
        // Then
        let _ = networkUtils.verify(verificationMode: Once()).isNetworkAvailable()
        XCTAssertEqual(false, isNetworkAvailable)
        
    }
    
    func testCheckNetworkUtilsShouldReturnTrue() {
        
        // Given
        let _ = networkUtils.when().call(withReturnValue: networkUtils.isNetworkAvailable()).thenReturn(true)
        
        // When
        let isNetworkAvailable = networkUtils.isNetworkAvailable()
        
        // Then
        let _ = networkUtils.verify(verificationMode: Once()).isNetworkAvailable()
        XCTAssertEqual(true, isNetworkAvailable)
        
    }

}
