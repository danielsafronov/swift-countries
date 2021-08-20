//
//  CountryView.swift
//  Countries
//
//  Created by Daniel Safronov on 29.07.2021.
//

import SwiftUI
import MapKit

struct CountryView: View {
    @ObservedObject private(set) var model: CountryViewModel
    
    init(container: Container, country: Country) {
        self.model = CountryViewModel(container: container, country: country)
    }
    
    var body: some View {
        ZStack(alignment: .leading)  {
            CountryMapView(
                coordinate: CLLocationCoordinate2D(
                    latitude: model.country.lat ?? 0,
                    longitude: model.country.lng ?? 0
                )
            )
            .ignoresSafeArea(edges: .top)
            
            VStack {
                Spacer()
                
                VStack {
                    VStack {
                        Group {
                            CountryItemView(title: "Name", value: model.country.name ?? "")
                            Divider()
                        }
                        
                        Group {
                            CountryItemView(title: "Code", value: model.country.alpha3Code ?? "")
                            Divider()
                        }
                        
                        Group {
                            CountryItemView(title: "Region", value: model.country.region ?? "")
                            Divider()
                        }

                        Group {
                            CountryItemView(title: "Subregion", value: model.country.subregion ?? "")
                            Divider()
                        }
                        
                        Group {
                            CountryItemView(title: "Capital", value: model.country.capital ?? "")
                            Divider()
                        }

                        CountryItemView(title: "Population", value: String(model.country.population ?? 0))
                    }
                    .padding()
                    .background(Color(.secondarySystemGroupedBackground))
                }
                .cornerRadius(10)
                .shadow(radius: 10)

            }
            .zIndex(1.0)
        }
        .ignoresSafeArea(edges: .all)
        .navigationBarTitle(model.country.name ?? "", displayMode: .inline)
    }
}

struct CountryView_Previews: PreviewProvider {
    static var previews: some View {
        CountryView(
            container: Container.defaultValue,
            country: Country(name: "Country Name", alpha3Code: "Country Code")
        )
        .environment(\.container, .defaultValue)
    }
}
