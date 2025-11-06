//
//  MapDetailView.swift
//  Apex Predators
//
//  Created by Samir Ramic on 06.11.25.
//
import SwiftUI
import MapKit

struct MapDetailView: View {
  
    let predator: ApexPredator
    @Binding var mapCameraPosition: MapCameraPosition
    
    var body: some View {
        Map(position: $mapCameraPosition){
            Annotation(predator.name, coordinate: predator.location){
                Image(predator.imageUrl)
                    .scaledToFit()
            }.annotationTitles(.hidden)
        }
    }
}

#Preview {
    @Previewable @State var mapCameraPosition: MapCameraPosition = .camera(MapCamera(centerCoordinate: PredatorFactory().allapexPredators[1].location, distance: 3000))
    let predator = PredatorFactory().allapexPredators[1]
    let position = predator.location
    
    MapDetailView(predator: predator, mapCameraPosition: $mapCameraPosition)
}
