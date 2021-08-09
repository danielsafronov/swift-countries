//
//  RemoteCountryRepository.swift
//  Countries
//
//  Created by Daniel Safronov on 06.08.2021.
//

import Foundation
import Combine

/// Remote country repository protocol.
protocol RemoteCountryRepositoryProtocol {
    /// Returns a ``AnyPublisher``  with array of ``Country``.
    /// - Returns: Instance of ``AnyPublisher``.
    func observe() -> AnyPublisher<[Country], Error>
}

/// Remote country repository.
struct RemoteCountryRepository: RemoteCountryRepositoryProtocol {
    private let sdk: CountrySDKProtocol
    
    init(sdk: CountrySDKProtocol) {
        self.sdk = sdk
    }
    
    /// Returns a ``AnyPublisher``  with array of ``Country``.
    /// - Returns: Instance of ``AnyPublisher``.
    func observe() -> AnyPublisher<[Country], Error> {
        return sdk.all()
            .tryMap { dtos in
                dtos.compactMap { dto in
                    Country(dto: dto)
                }
            }
            .eraseToAnyPublisher()
    }
}
