//
//  Country.swift
//  Countries
//
//  Created by Daniel Safronov on 06.08.2021.
//

import Foundation

struct CountryNetworkDto: Codable, Equatable {
    var name: String? = nil
    var alpha3Code: String? = nil
    var region: String? = nil
    var subregion: String? = nil
    var population: Int64? = nil
    var latlng: [Double]? = nil
}
