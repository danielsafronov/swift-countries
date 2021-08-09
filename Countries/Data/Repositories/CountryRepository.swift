//
//  CountryRepository.swift
//  Countries
//
//  Created by Daniel Safronov on 26.07.2021.
//

import Foundation
import Combine
import CoreData

/// Country repository protocol.
protocol CountryRepositoryProtocol {
    var localRepository: LocalCountryRepositoryProtocol { get set }
    var remoteRepository: RemoteCountryRepositoryProtocol { get set }
    
    /// Returns a ``AnyPublisher``  with array of ``Country``.
    /// - Returns: Instance of ``AnyPublisher``.
    func observe() -> AnyPublisher<[Country], Error>
}

/// Country repository.
struct CountryRepository: CountryRepositoryProtocol {
    var localRepository: LocalCountryRepositoryProtocol
    var remoteRepository: RemoteCountryRepositoryProtocol
    
    init(localRepository: LocalCountryRepositoryProtocol, remoteRepository: RemoteCountryRepositoryProtocol) {
        self.localRepository = localRepository
        self.remoteRepository = remoteRepository
    }
    
    /// Returns a ``AnyPublisher``  with array of ``Country``.
    /// - Returns: Instance of ``AnyPublisher``.
    func observe() -> AnyPublisher<[Country], Error> {
        return remoteRepository.observe()
            .removeDuplicates()
            .tryMap { [localRepository] in
                $0.forEach { country in
                    localRepository.store(item: country)
                }
            }
            .flatMap { [localRepository] in
                localRepository.observe()
            }
            .eraseToAnyPublisher()
    }
}
