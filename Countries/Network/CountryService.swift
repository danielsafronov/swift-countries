//
//  NetworkService.swift
//  Countries
//
//  Created by Daniel Safronov on 06.08.2021.
//

import Foundation
import Combine

/// Country Service protocol.
protocol CountryServiceProtocol {
    /// Returns a ``AnyPublisher``  with array of ``CountryNetworkDto``.
    /// - Returns: Instance of ``AnyPublisher``.
    func all() -> AnyPublisher<[CountryNetworkDto], Error>
}

/// Country service.
struct CountryService: CountryServiceProtocol {
    private let session: URLSession
    private let retry: Int
    
    init(configuration: URLSessionConfiguration = .default, retry: Int = 1) {
        self.session = URLSession(configuration: configuration)
        self.retry = retry
    }
    
    /// Returns a ``AnyPublisher``  with array of ``CountryNetworkDto``.
    /// - Returns: Instance of ``AnyPublisher``.
    func all() -> AnyPublisher<[CountryNetworkDto], Error> {
        guard let request = try? CountryEndproint.all.getRequest() else {
            return CurrentValueSubject([]).eraseToAnyPublisher()
        }
        
        return session
            .dataTaskPublisher(for: request)
            .tryMap {
                guard let response = $0.response as? HTTPURLResponse, response.statusCode == NetworkStatusCode.ok.rawValue else {
                    throw NetworkError.clientError
                }
                return $0.data
            }
            .decode(type: [CountryNetworkDto].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .retry(retry)
            .eraseToAnyPublisher()
    }
}
