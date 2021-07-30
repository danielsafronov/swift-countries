//
//  Endpoint.swift
//  Countries
//
//  Created by Daniel Safronov on 26.07.2021.
//

import Foundation

/// Endpoint protocol.
protocol EndpointProtocol {
    var base: String { get }
    var path: String { get }
}

extension EndpointProtocol {
    /// Returns URL request.
    func getRequest() throws -> URLRequest {
        guard let url = URL(string: base + path) else {
            throw EndpointError.unableToCreateUrl
        }
        
        return URLRequest(url: url)
    }
}

/// Endpoint error.
enum EndpointError: Error {
    case unableToCreateUrl
}

/// Country endpoint.
enum CountryEndproint {
    case all
}

extension CountryEndproint: EndpointProtocol {
    var base: String {
        return "https://restcountries.eu/rest"
    }
    
    var path: String {
        switch self {
            case .all: return "/v2/all"
        }
    }
}

