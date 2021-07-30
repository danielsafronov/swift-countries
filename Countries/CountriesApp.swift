//
//  CountriesApp.swift
//  Countries
//
//  Created by Daniel Safronov on 26.07.2021.
//

import SwiftUI
import CoreData

@main
struct CountriesApp: App {
    let persistenceController: PersistenceController
    let container: Container
    
    init() {
        self.persistenceController = PersistenceController.shared
        self.container = Application.boostrap(container: persistenceController.container).container
    }

    var body: some Scene {
        WindowGroup {
            CountryListView(container: container)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environment(\.container, container)
        }
    }
}
