//
//  LocalCountryRepository.swift
//  Countries
//
//  Created by Daniel Safronov on 06.08.2021.
//

import Foundation
import CoreData
import Combine

/// Local country repository protocol.
protocol LocalCountryRepositoryProtocol {
    /// Returns a ``AnyPublisher``  with array of ``Country``.
    /// - Returns: Instance of ``AnyPublisher``.
    func observe() -> AnyPublisher<[Country], Error>
    
    /// Store ``Country`` instance.
    /// - Parameter item: Instance of ``Country``.
    func store(item: Country)
}

/// Local country repository.
struct LocalCountryRepository: LocalCountryRepositoryProtocol {
    let container: NSPersistentContainer
    
    /// Returns a ``AnyPublisher``  with array of ``Country``.
    /// - Returns: Instance of ``AnyPublisher``.
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
    
    /// Store ``Country`` instance.
    /// - Parameter item: Instance of ``Country``.
    func store(item: Country) {
        let _ = CountryMO(entity: item, insertInto: container.viewContext)
    }
}
