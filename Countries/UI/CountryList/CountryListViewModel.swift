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
    @Published var serach: String = "" {
        didSet {
            load()
        }
    }
    
    let container: Container
    
    private var cancellable: AnyCancellable?
    
    init(container: Container) {
        self.container = container
        load()
    }
    
    func load() {
        if let repository = self.container.countryRepository {
            self.cancellable = repository.observe()
                .sink(
                    receiveCompletion: { _ in },
                    receiveValue: { [self] output in
                        var countries = output
                        
                        if !serach.isEmpty {
                            countries = countries.filter { [self] country in
                                country.name?.contains(self.serach) ?? true
                            }
                        }
                        
                        self.countries = Array(Set(countries)).sorted { fc, sc in
                            fc.name ?? "" < sc.name ?? ""
                        }
                    }
                )
        }
    }
}
