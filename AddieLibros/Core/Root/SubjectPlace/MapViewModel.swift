//
//  MapViewModel.swift
//  AddieLibros
//
//  Created by cristian regina on 6/1/24.
//

import Foundation
import MapKit
import SwiftUI

class MapViewModel: ObservableObject {
    
    @Published var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(
            latitude: 51.50 ,
            longitude: -0.1275),
        span: MKCoordinateSpan(
            latitudeDelta: 5,
            longitudeDelta: 5)
    )
    @Published var coordinates = []
    @Published var location: Location = Location()
    @Published var cameraPosition = MapCameraPosition
        .region(
            MKCoordinateRegion(
                center: CLLocationCoordinate2D(
                    latitude: 51.50 ,
                    longitude: -0.1275),
                span: MKCoordinateSpan(
                    latitudeDelta: 5,
                    longitudeDelta: 5)
            )
        )
    
    func getLocation(query: String){
        Task{
            let newCoordinates = try await NetworkManager.shared.getLocation(address: query, delta: 5).data[0]
            let lat = newCoordinates.latitude
            let long = newCoordinates.longitude
            DispatchQueue.main.async{
                self.coordinates = [lat, long]
                self.region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: lat , longitude: long), span: MKCoordinateSpan(latitudeDelta: 5, longitudeDelta: 5))
                self.location = Location(name: newCoordinates.name ?? "Pin", coordinate: CLLocationCoordinate2D(latitude: lat , longitude: long))
                self.cameraPosition = MapCameraPosition.region(self.region)
            }
        }
    }
    
}
