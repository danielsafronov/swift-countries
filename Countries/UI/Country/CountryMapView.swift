//
//  MapView.swift
//  Countries
//
//  Created by Daniel Safronov on 29.07.2021.
//

import SwiftUI
import MapKit

struct CountryMapView: View {
    var coordinate: CLLocationCoordinate2D
    
    @State private var region = MKCoordinateRegion()

    var body: some View {
        Map(coordinateRegion: $region, interactionModes: [])
            .onAppear { setRegion(coordinate) }
            .onTapGesture {
                redirectToUrl(latitude: coordinate.latitude, longitude: coordinate.longitude)
            }
    }

    private func setRegion(_ coordinate: CLLocationCoordinate2D) {
        region = MKCoordinateRegion(
            center: coordinate,
            span: MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10)
        )
    }
    
    private func redirectToUrl(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        UIApplication.shared.open(
            NSURL(
                string: "https://maps.apple.com/?ll=\(latitude),\(longitude)&spn=10,10"
            )! as URL
        )
    }
}

struct CountryMapView_Previews: PreviewProvider {
    static var previews: some View {
        CountryMapView(
            coordinate: CLLocationCoordinate2D(latitude: 34.011_286, longitude: -116.166_868)
        )
    }
}
