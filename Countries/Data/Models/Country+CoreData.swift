//
//  Country+CoreData.swift
//  Countries
//
//  Created by Daniel Safronov on 26.07.2021.
//

import Foundation
import CoreData

extension Country {
    init?(mo: CountryMO) {
        self.init(
            name: mo.name,
            alpha3Code: mo.alpha3Code,
            region: mo.region,
            subregion: mo.subregion,
            population: mo.population,
            lat: mo.lat,
            lng: mo.lng
        )
    }
}

extension CountryMO {
    convenience init?(entity: Country, insertInto context: NSManagedObjectContext) {
        self.init(context: context)
        
        name = entity.name
        alpha3Code = entity.alpha3Code
        region = entity.region
        subregion = entity.subregion
        population = entity.population ?? 0
        lat = entity.lat ?? 0.0
        lng = entity.lng ?? 0.0
    }
}
