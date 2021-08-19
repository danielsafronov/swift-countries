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
            VStack {
                List {
                    Section(
                        header: VStack {
                            HStack {
                                Image(systemName: "magnifyingglass")
                                    .foregroundColor(Color(.gray))
                                
                                TextField("Search", text: $model.serach)
                                    .textFieldStyle(SearchTextFieldStyle())
                                
                                if !model.serach.isEmpty {
                                    Image(systemName: "xmark.circle.fill")
                                        .onTapGesture {
                                            model.serach = ""
                                        }
                                }
                            }
                            .padding(
                                EdgeInsets(
                                    top: 10.0,
                                    leading: 15.0,
                                    bottom: 10.0,
                                    trailing: 15.0
                                )
                            )
                        }
                        .background(Color(.secondarySystemGroupedBackground))
                        .cornerRadius(10.0)
                        .padding(
                            EdgeInsets(
                                top: 0.0,
                                leading: 0.0,
                                bottom: 10,
                                trailing: 0.0
                            )
                        )
                    ) {
                        ForEach(model.countries, id: \.id) { country in
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
                    }
                }
                .listStyle(InsetGroupedListStyle())
            }
            .navigationTitle(Text("Countries"))
        }
    }
}

struct CountryListView_Previews: PreviewProvider {
    static var previews: some View {
        CountryListView(container: Container.defaultValue)
            .environment(\.container, .defaultValue)
    }
}

private struct SearchTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<_Label>) -> some View {
        configuration
            .font(.body)
            .foregroundColor(Color(.label))
            .textCase(.none)
    }
}
