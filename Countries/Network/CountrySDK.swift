//
//  CountrySDK.swift
//  Countries
//
//  Created by Daniel Safronov on 06.08.2021.
//

import Foundation
import Combine

/// Country SDK protocol.
protocol CountrySDKProtocol {
    /// Returns a ``AnyPublisher``  with array of ``CountryNetworkDto``.
    /// - Returns: Instance of ``AnyPublisher``.
    func all() -> AnyPublisher<[CountryNetworkDto], Error>
}

/// Country SDK.
struct CountrySDK: CountrySDKProtocol {
    private let service: CountryServiceProtocol
    
    init(service: CountryServiceProtocol) {
        self.service = service
    }
    
    /// Returns a ``AnyPublisher``  with array of ``CountryNetworkDto``.
    /// - Returns: Instance of ``AnyPublisher``.
    func all() -> AnyPublisher<[CountryNetworkDto], Error> {
        return service.all()
    }
}
