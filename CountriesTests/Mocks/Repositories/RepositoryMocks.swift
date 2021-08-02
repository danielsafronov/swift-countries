//
//  RepositoryMocks.swift
//  CountriesTests
//
//  Created by Daniel Safronov on 02.08.2021.
//

import Foundation
import Combine
@testable import Countries

class LocalCountryRepositoryMock: LocalCountryRepositoryProtocol {
    var observeCallCount: Int = 0
    var storeCallCount: Int = 0
    
    func observe() -> AnyPublisher<[Country], Error> {
        observeCallCount += 1
        
        let countries = [
            Country.factory.create(alpha3Code: "Local AplphaCode 0"),
            Country.factory.create(alpha3Code: "Local AplphaCode 1"),
            Country.factory.create(alpha3Code: "Local AplphaCode 2"),
        ]
        
        return Result.Publisher(countries).delay(for: .milliseconds(10), scheduler: RunLoop.main).eraseToAnyPublisher()

    }
    
    func store(item: Country) {
        storeCallCount += 1
        return
    }
}

class RemoteCountryRepositoryMock: RemoteCountryRepositoryProtocol {
    var observeCallCount: Int = 0
    
    func observe() -> AnyPublisher<[Country], Error> {
        observeCallCount += 1
        
        let countries = [
            Country.factory.create(alpha3Code: "Remote AplphaCode 0"),
            Country.factory.create(alpha3Code: "Remote AplphaCode 1"),
            Country.factory.create(alpha3Code: "Remote AplphaCode 2"),
        ]
        
        return Result.Publisher(countries).delay(for: .milliseconds(10), scheduler: RunLoop.main).eraseToAnyPublisher()
    }
}
