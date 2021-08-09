//
//  Country.swift
//  Countries
//
//  Created by Daniel Safronov on 26.07.2021.
//

import Foundation

struct Country: Codable, Equatable {
    var name: String? = nil
    var alpha3Code: String? = nil
    var region: String? = nil
    var subregion: String? = nil
    var population: Int64? = nil
    var lat: Double? = nil
    var lng: Double? = nil
}

extension Country: Identifiable {
    var id: String? { alpha3Code }
}

extension Country {
    init?(dto: CountryNetworkDto) {
        var lat = 0.0
        var lng = 0.0
        
        if dto.latlng?.count == 2 {
            lat = dto.latlng?[0] ?? 0.0
            lng = dto.latlng?[1] ?? 0.0
        }
        
        self.init(
            name: dto.name,
            alpha3Code: dto.alpha3Code,
            region: dto.region,
            subregion: dto.subregion,
            population: dto.population,
            lat: lat,
            lng: lng
        )
    }
}
