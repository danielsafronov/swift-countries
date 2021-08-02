//
//  CountryTests.swift
//  CountriesTests
//
//  Created by Daniel Safronov on 02.08.2021.
//

import XCTest
import CoreData
@testable import Countries

class CountryTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testInitFromMO() throws {
        let countryMO = CountryMO.factory.create()
        let country = Country(mo: countryMO)
        
        XCTAssertEqual("Alpha3Code", country?.id)
        XCTAssertEqual("Name", country?.name)
        XCTAssertEqual("Alpha3Code", country?.alpha3Code)
        XCTAssertEqual("Region", country?.region)
        XCTAssertEqual("Subregion", country?.subregion)
        XCTAssertEqual(0, country?.population)
        XCTAssertEqual(0.0, country?.lat)
        XCTAssertEqual(0.0, country?.lng)
    }

    func testInitFromNetworkDtoWithLatLng() throws {
        let countryNetworkDto = CountryNetworkDto.factory.create()
        let country = Country(dto: countryNetworkDto)
        
        XCTAssertEqual(countryNetworkDto.alpha3Code, country?.id)
        XCTAssertEqual(countryNetworkDto.name, country?.name)
        XCTAssertEqual(countryNetworkDto.alpha3Code, country?.alpha3Code)
        XCTAssertEqual(countryNetworkDto.region, country?.region)
        XCTAssertEqual(countryNetworkDto.subregion, country?.subregion)
        XCTAssertEqual(countryNetworkDto.population, country?.population)
        XCTAssertEqual(countryNetworkDto.latlng?[0], country?.lat)
        XCTAssertEqual(countryNetworkDto.latlng?[1], country?.lng)
    }
    
    func testInitFromNetworkDtoWithoutLatLng() throws {
        let countryNetworkDto = CountryNetworkDto.factory.create(latlng: nil)
        let country = Country(dto: countryNetworkDto)
        
        XCTAssertEqual(countryNetworkDto.alpha3Code, country?.id)
        XCTAssertEqual(countryNetworkDto.name, country?.name)
        XCTAssertEqual(countryNetworkDto.alpha3Code, country?.alpha3Code)
        XCTAssertEqual(countryNetworkDto.region, country?.region)
        XCTAssertEqual(countryNetworkDto.subregion, country?.subregion)
        XCTAssertEqual(countryNetworkDto.population, country?.population)
        XCTAssertEqual(0.0, country?.lat)
        XCTAssertEqual(0.0, country?.lng)
    }
}
