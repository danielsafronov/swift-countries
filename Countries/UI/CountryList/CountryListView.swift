//
//  CountryListView.swift
//  Countries
//
//  Created by Daniel Safronov on 26.07.2021.
//

import SwiftUI
import Combine

struct CountryListView: View {
    @ObservedObject private(set) var model: CountryListViewModel

    init(container: Container) {
        self.model = CountryListViewModel(container: container)
    }

    var body: some View {
        NavigationView {
            List(model.countries, id: \.id) { country in
                NavigationLink(
                    destination: CountryView(
                        container: model.container,
                        country: country
                    ),
                    label: {
                        CountryListItemView(
                            title: country.name ?? "",
                            code: country.alpha3Code ?? ""
                        )
                    }
                )
            }
            .listStyle(InsetGroupedListStyle())
            .navigationTitle("Countries")
        }
    }
}

struct CountryListView_Previews: PreviewProvider {
    static var previews: some View {
        CountryListView(container: Container.defaultValue)
            .environment(\.container, .defaultValue)
    }
}
