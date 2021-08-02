//
//  CountyListViewUITest.swift
//  CountriesUITests
//
//  Created by Daniel Safronov on 30.07.2021.
//

import XCTest

class CountyListViewUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
        XCUIApplication().launch()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testNavigationBarExists() throws {
        let application = XCUIApplication()
        let element = application.navigationBars["Countries"]
        
        XCTAssert(element.exists)
    }
}
