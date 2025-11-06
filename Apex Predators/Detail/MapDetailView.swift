//
//  MapDetailView.swift
//  Apex Predators
//
//  Created by Samir Ramic on 06.11.25.
//
import SwiftUI
import MapKit

struct MapDetailView: View {
  
    let predators: [ApexPredator] = PredatorFactory().allapexPredators
    @State var mapCameraPosition: MapCameraPosition
    
    var body: some View {
        Map(position: $mapCameraPosition){
            ForEach(predators){ predator in
                Annotation(predator.name, coordinate: predator.location){
                    Image(predator.imageUrl)
                        .resizable()
                        .frame(width: 100, height: 100)
                }.annotationTitles(.hidden)
            }
        }
    }
}

#Preview {
    @Previewable @State var mapCameraPosition: MapCameraPosition = .camera(MapCamera(centerCoordinate: PredatorFactory().allapexPredators[1].location, distance: 3000))
    let predator = PredatorFactory().allapexPredators[1]
    let position = predator.location
    
    MapDetailView(mapCameraPosition: mapCameraPosition)
}
