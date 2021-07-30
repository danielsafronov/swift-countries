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
                        CountryItemView(title: "Name", value: model.country.name ?? "")
                        Divider()
                        
                        CountryItemView(title: "Code", value: model.country.alpha3Code ?? "")
                        Divider()
                        
                        CountryItemView(title: "Region", value: model.country.region ?? "")
                        Divider()

                        CountryItemView(title: "Subregion", value: model.country.subregion ?? "")
                        Divider()

                        CountryItemView(title: "Population", value: String(model.country.population ?? 0))
                    }
                    .padding()
                    .background(Color(.secondarySystemBackground))
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
        .preferredColorScheme(.light)
        .environment(\.container, .defaultValue)
    }
}
