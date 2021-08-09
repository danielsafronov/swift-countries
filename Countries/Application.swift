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
    static func bootstrap(container: NSPersistentContainer) -> Self {
        let container = bootstrapContainer(container: container)
        
        return Application(container: container)
    }
}

extension Application {
    private static func bootstrapContainer(container: NSPersistentContainer) -> Container {
        let service = bootstrapCountryService()
        let sdk = bootstrapCountrySdk(service: service)
        
        let localCountryRepository = bootstrapLocalCountryRepository(container: container)
        let remoteCountryRepository = bootstrapRemoteCountryRepository(sdk: sdk)
        let countryRepository = bootstrapCountryRepository(
            localRepository: localCountryRepository,
            remoteRepository: remoteCountryRepository
        )
        
        return Container(countryRepository: countryRepository)
    }
}

extension Application {
    private static func bootstrapCountryRepository(
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
    private static func bootstrapLocalCountryRepository(
        container: NSPersistentContainer
    ) -> LocalCountryRepositoryProtocol {
        return LocalCountryRepository(container: container)
    }
}

extension Application {
    private static func bootstrapRemoteCountryRepository(sdk: CountrySDKProtocol) -> RemoteCountryRepositoryProtocol {
        return RemoteCountryRepository(sdk: sdk)
    }
}

extension Application {
    private static func bootstrapCountrySdk(service: CountryServiceProtocol) -> CountrySDKProtocol {
        return CountrySDK(service: service)
    }
}

extension Application {
    private static func bootstrapCountryService() -> CountryServiceProtocol {
        return CountryService()
    }
}
