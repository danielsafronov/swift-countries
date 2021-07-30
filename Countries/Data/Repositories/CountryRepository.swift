//
//  CountryRepository.swift
//  Countries
//
//  Created by Daniel Safronov on 26.07.2021.
//

import Foundation
import Combine
import CoreData

/// Local country repository protocol.
protocol LocalCountryRepositoryProtocol {
    /// Returns a country publisher.
    func observe() -> AnyPublisher<[Country], Error>
    
    /// Store country instance in local storage.
    /// - Parameter item: country instance.
    func store(item: Country)
}

/// Remote country repository protocol.
protocol RemoteCountryRepositoryProtocol {
    /// Returns a country publisher.
    func observe() -> AnyPublisher<[Country], Error>
}

/// Country repository protocol.
protocol CountryRepositoryProtocol {
    var localRepository: LocalCountryRepositoryProtocol { get set }
    var remoteRepository: RemoteCountryRepositoryProtocol { get set }
    
    /// Returns a country publisher.
    func observe() -> AnyPublisher<[Country], Error>
}

/// Country repository wich combine local and remote data storage.
class CountryRepository: CountryRepositoryProtocol {
    var localRepository: LocalCountryRepositoryProtocol
    var remoteRepository: RemoteCountryRepositoryProtocol
    
    init(localRepository: LocalCountryRepositoryProtocol, remoteRepository: RemoteCountryRepositoryProtocol) {
        self.localRepository = localRepository
        self.remoteRepository = remoteRepository
    }
    
    /// Observe countries.
    /// - Returns: A publisher which provide countries.
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

/// Local country repository.
struct LocalCountryRepository: LocalCountryRepositoryProtocol {
    let container: NSPersistentContainer
    
    /// Returns a countries publisher.
    /// - Returns: A publisher which provide countries fetched from local storage.
    func observe() -> AnyPublisher<[Country], Error> {
        return Future<[Country], Error> { [weak container] promise in
            let request = NSFetchRequest<CountryMO>(entityName: "Country")
            request.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
            
            do {
                let managedObjects = try container?.viewContext.fetch(request) ?? []
                let items = managedObjects
                    .compactMap { item in Country(mo: item ) }
                
                promise(.success(items))
            } catch {
                promise(.failure(error))
            }
        }
        .eraseToAnyPublisher()
    }
    
    /// Store country instance in local storage.
    /// - Parameter item: country instance.
    func store(item: Country) {
        CountryMO(entity: item, insertInto: container.viewContext)
    }
}

/// Remote country repository.
struct RemoteCountryRepository: RemoteCountryRepositoryProtocol {
    let session: URLSession
    
    init(configuration: URLSessionConfiguration) {
        self.session = URLSession(configuration: configuration)
    }
    
    init() {
        self.init(configuration: .default)
    }
    
    /// Returns a countries publisher.
    /// - Returns: A publisher which provide countries fetched from remote storage.
    func observe() -> AnyPublisher<[Country], Error> {
        guard let request = try? CountryEndproint.all.getRequest() else {
            return Just<[Country]>([])
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        }
        
        return session
            .dataTaskPublisher(for: request)
            .tryMap {
                guard let response = $0.response as? HTTPURLResponse, response.statusCode == 200 else {
                    throw NetworkError.clientError
                }
                return $0.data
            }
            .decode(type: [CountryNetworkDto].self, decoder: JSONDecoder())
            .tryMap { dtos in
                try dtos.compactMap { dto in
                    try Country(dto: dto)
                }
            }
            .receive(on: DispatchQueue.main)
            .retry(1)
            .eraseToAnyPublisher()
    }
}
