//
//  Application.swift
//  Countries
//
//  Created by Daniel Safronov on 26.07.2021.
//

import Foundation
import CoreData

struct Application {
    let container: Container
}

extension Application {
    static func boostrap(container: NSPersistentContainer) -> Self {
        let container = boostrapContainer(container: container)
        
        return Application(container: container)
    }
}

extension Application {
    private static func boostrapContainer(container: NSPersistentContainer) -> Container {
        let localCountryRepository = boostrapLocalCountryRepository(container: container)
        let remoteCountryRepository = boostrapRemoteCountryRepository()
        let countryRepository = boostrapCountryRepository(
            localRepository: localCountryRepository,
            remoteRepository: remoteCountryRepository
        )
        
        return Container(countryRepository: countryRepository)
    }
}

extension Application {
    private static func boostrapCountryRepository(
        localRepository: LocalCountryRepositoryProtocol,
        remoteRepository: RemoteCountryRepositoryProtocol
    ) -> CountryRepositoryProtocol {
        return CountryRepository(
            localRepository: localRepository,
            remoteRepository: remoteRepository
        )
    }
}

extension Application {
    private static func boostrapRemoteCountryRepository() -> RemoteCountryRepositoryProtocol {
        return RemoteCountryRepository()
    }
}

extension Application {
    private static func boostrapLocalCountryRepository(
        container: NSPersistentContainer
    ) -> LocalCountryRepositoryProtocol {
        return LocalCountryRepository(container: container)
    }
}
