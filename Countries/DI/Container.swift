//
//  Container.swift
//  Countries
//
//  Created by Daniel Safronov on 26.07.2021.
//

import Foundation
import SwiftUI

struct Container: EnvironmentKey {
    let countryRepository: CountryRepositoryProtocol?
    
    static var defaultValue: Self { Self.default }
    private static let `default` = Self(countryRepository: nil)
}

extension EnvironmentValues {
    var container: Container {
        get { self[Container.self] }
        set { self[Container.self] = newValue }
    }
}
