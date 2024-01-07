//
//  SubjectPlace.swift
//  AddieLibros
//
//  Created by cristian regina on 6/1/24.
//

import SwiftUI
import MapKit

struct SubjectPlace: View {
    
    @Binding var place: String
    @Binding var isShowingMap: Bool
    @StateObject var viewModel = MapViewModel()
    
    var body: some View {
        let coordinate = viewModel.location.coordinate
        let label = viewModel.location.name
        VStack{
            
            /*Map(initialPosition: MapCameraPosition.region(viewModel.region)){
                Marker(viewModel.location.name, coordinate: viewModel.location.coordinate)
            }*/
            
            Map{
                Marker(label, coordinate: viewModel.location.coordinate)
            }
            
        }
        .frame(width: 325, height: 600)
            .background(Color(.systemBackground))
            .cornerRadius(12)
            .shadow(radius: 40)
            .overlay(
                Button {
                    isShowingMap = false
                } label: {
                    XDismissButton()
                }, alignment: .topTrailing)
            .onAppear{
                viewModel.getLocation(query: place)
                print(viewModel.location)
            }
    }
}
