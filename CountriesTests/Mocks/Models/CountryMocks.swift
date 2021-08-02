//
//  Countries.swift
//  CountriesTests
//
//  Created by Daniel Safronov on 02.08.2021.
//

import Foundation
@testable import Countries

extension CountryNetworkDto {
    struct Factory {
        func create(
            name: String? = "Name",
            alpha3Code: String? = "Alpha3Code",
            region: String? = "Region",
            subregion: String? = "Subregion",
            population: Int64? = Int64.random(in: 0...INT64_MAX),
            latlng: [Double]? = [Double.random(in: 0.0...1.0), Double.random(in: 0.0...1.0)]
        ) -> CountryNetworkDto {
            return CountryNetworkDto(
                name: name,
                alpha3Code: alpha3Code,
                region: region,
                subregion: subregion,
                population: population,
                latlng: latlng
            )
        }
    }
    
    static let factory: Factory = Factory()
}

extension Country {
    struct Factory {
        func create(
            name: String? = "Name",
            alpha3Code: String? = "Alpha3Code",
            region: String? = "Region",
            subregion: String? = "Subregion",
            population: Int64? = Int64.random(in: 0...INT64_MAX),
            lat: Double? = Double.random(in: 0.0...1.0),
            lng: Double? = Double.random(in: 0.0...1.0)
        ) -> Country {
            return Country(
                name: name,
                alpha3Code: alpha3Code,
                region: region,
                subregion: subregion,
                population: population,
                lat: lat,
                lng: lng
            )
        }
    }
    
    static let factory: Factory = Factory()
}

extension CountryMO {
    struct Factory {
        func create(
            name: String? = "Name",
            alpha3Code: String? = "Alpha3Code",
            region: String? = "Region",
            subregion: String? = "Subregion",
            population: Int64? = Int64.random(in: 0...INT64_MAX),
            lat: Double? = Double.random(in: 0.0...1.0),
            lng: Double? = Double.random(in: 0.0...1.0)
        ) -> CountryMO {
            let countryMO = CountryMO(context: PersistenceController.init(inMemory: true).container.viewContext)
            countryMO.name = "Name"
            countryMO.alpha3Code = "Alpha3Code"
            countryMO.region = "Region"
            countryMO.subregion = "Subregion"
            countryMO.population = 0
            countryMO.lat = 0.0
            countryMO.lng = 0.0
            
            return countryMO
        }
    }
    
    static let factory: Factory = Factory()
}
