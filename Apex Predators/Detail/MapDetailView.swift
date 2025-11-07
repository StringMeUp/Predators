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
    @State var satelite: Bool = false
    
    var body: some View {
        Map(position: $mapCameraPosition){
            ForEach(predators){ predator in
                Annotation(predator.name, coordinate: predator.location){
                    Image(predator.imageUrl)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 100)
                        .shadow(color: .white, radius: 10)
                        .scaleEffect(x: -1)
                }.annotationTitles(.hidden)
            }
        }
        .mapStyle(
            satelite ? 
                .imagery(elevation: .realistic) : 
                    .standard(elevation: .realistic)
        )
        .overlay(alignment: .bottomTrailing) {
            Button{
                satelite.toggle()
            } label: {
                Image(systemName: satelite ? "globe.americas.fill" : "globe.americas")
                    .font(.largeTitle)
                    .imageScale(.large)
                    .padding(.trailing, 25)
                    .background(.ultraThinMaterial)
            }
        }
    }
}

#Preview {
    @Previewable @State var mapCameraPosition: MapCameraPosition = .camera(MapCamera(
        centerCoordinate: PredatorFactory().allapexPredators[2].location,
        distance: 1000,
        heading: 250,
        pitch: 80))
    
    let predator = PredatorFactory().allapexPredators[2]
    let position = predator.location
    
    MapDetailView(mapCameraPosition: mapCameraPosition)
        .preferredColorScheme(.dark)
}
