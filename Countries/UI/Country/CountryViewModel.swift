//
//  CountryViewModel.swift
//  Countries
//
//  Created by Daniel Safronov on 29.07.2021.
//

import Foundation
import Combine

class CountryViewModel: ObservableObject {
    @Published var country: Country
    
    let container: Container
    
    init(container: Container, country: Country) {
        self.container = container
        self.country = country
    }
}
