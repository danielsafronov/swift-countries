//
//  CountryRepositoryTests.swift
//  CountriesTests
//
//  Created by Daniel Safronov on 02.08.2021.
//

import XCTest
import Combine
@testable import Countries

class CountryRepositoryTests: XCTestCase {
    var subscriptions = Set<AnyCancellable>()

    override func setUpWithError() throws {
        subscriptions = []
    }

    override func tearDownWithError() throws {
        subscriptions = []
    }

    func testObserve() throws {
        let localRepositoryMock = LocalCountryRepositoryMock()
        let remoteRepositoryMock = RemoteCountryRepositoryMock()
        let repository = CountryRepository(localRepository: localRepositoryMock, remoteRepository: remoteRepositoryMock)
        let expectation = XCTestExpectation(description: #function)

        let _ = repository.observe()
            .sink(
                receiveCompletion: { _ in},
                receiveValue: { countries in
                    XCTAssertEqual(3, countries.count)
                    expectation.fulfill()
                }
            )
            .store(in: &subscriptions)
        
        wait(for: [expectation], timeout: 10)

        XCTAssertEqual(1, remoteRepositoryMock.observeCallCount)
        XCTAssertEqual(3, localRepositoryMock.storeCallCount)
        XCTAssertEqual(1, localRepositoryMock.observeCallCount)
    }
}
