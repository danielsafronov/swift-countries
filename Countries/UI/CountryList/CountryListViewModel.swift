//
//  CountryListViewModel.swift
//  Countries
//
//  Created by Daniel Safronov on 27.07.2021.
//

import Foundation
import Combine

class CountryListViewModel: ObservableObject {
    @Published var countries: [Country] = []
    
    let container: Container
    
    private var cancellable: AnyCancellable?
    
    init(container: Container) {
        self.container = container
        
        if let repository = self.container.countryRepository {
            self.cancellable = repository.observe()
                .sink(
                    receiveCompletion: { _ in },
                    receiveValue: { [self] output in
                        self.countries = output
                    }
                )
        }
    }
}
