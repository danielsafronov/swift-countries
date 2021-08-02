//
//  EndpointTests.swift
//  CountriesTests
//
//  Created by Daniel Safronov on 02.08.2021.
//

import XCTest
@testable import Countries

class EndpointTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testGetRequest() throws {
        let request = try EndpointMock.test.getRequest()
        
        XCTAssertEqual("https://test.com/test", request.url?.absoluteString)
    }
}
