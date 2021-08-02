//
//  EndpointMock.swift
//  CountriesTests
//
//  Created by Daniel Safronov on 02.08.2021.
//

import Foundation
@testable import Countries

enum EndpointMock {
    case test
}

extension EndpointMock: EndpointProtocol {
    var base: String {
        return "https://test.com"
    }
    
    var path: String {
        switch self {
            case .test: return "/test"
        }
    }
}
