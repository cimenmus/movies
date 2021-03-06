//
//  MockNetworkUtils.swift
//  MoviesTests
//
//  Created by mustafa içmen on 6.03.2021.
//

import Foundation
import XCTest
import Mockit
@testable import Movies

class MockNetworkUtils: NetworkUtils, Mock {
    
    let callHandler: CallHandler

    init(testCase: XCTestCase) {
        callHandler = CallHandlerImpl(withTestCase: testCase)
    }

    func instanceType() -> MockNetworkUtils {
        return self
    }
    
    override func isNetworkAvailable() -> Bool {
        return callHandler.accept(false, ofFunction: #function, atFile: #file, inLine: #line, withArgs: nil) as! Bool
    }
    
}
