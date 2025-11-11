//
//  PredatorDetailView.swift
//  Apex Predators
//
//  Created by Samir Ramic on 25.10.25.
//

import SwiftUI
import MapKit

struct PredatorDetailView: View {
    
    var predator: ApexPredator
    @State var mapCameraPosition: MapCameraPosition
    @Namespace var namespace

    var body: some View {
        GeometryReader{ geo in
            ScrollView {
                ZStack(alignment: Alignment.bottomTrailing) {
                    // Background Image
                    Image(predator.type.rawValue)
                        .resizable()
                        .scaledToFit().overlay {
                            LinearGradient(stops: [
                                Gradient.Stop(color: .clear, location: 0.8),
                                Gradient.Stop(color: .black, location: 1.0),
                            ], startPoint: .top, endPoint: .bottom)
                        }
                
                    // Dino Image
                    Image(predator.imageUrl)
                        .resizable()
                        .frame(
                            width: geo.size.width/1.5,
                            height: geo.size.height/3.8
                        )
                        .scaleEffect(x: -1)
                        .shadow(color: .black, radius: 7)
                        .offset(y: 20)
                }
                
                Spacer().frame(height: 50)
                
                VStack(alignment: .leading, spacing: 20) {
                    // Name
                    Text(predator.name)
                        .font(.largeTitle)
                    
                    // Location
                    NavigationLink {
                        MapDetailView(
                            mapCameraPosition: 
                                    .camera(
                                        MapCamera(
                                            centerCoordinate: predator.location,
                                            distance: 1000,
                                            heading: 250,
                                            pitch: 80
                                        )
                                    )
                        ).navigationTransition(.zoom(sourceID: 1, in: namespace))
                    } label: {
                        Map(position: $mapCameraPosition){
                            Annotation(
                                predator.name,
                                coordinate: predator.location
                            ){
                                Image(systemName: "mappin.and.ellipse")
                                    .font(.largeTitle)
                                    .imageScale(.large)
                                    .symbolEffect(.pulse)
                                
                            }.annotationTitles(.hidden)
                        }
                        .allowsHitTesting(false)
                        .frame(height: 150)
                        .clipShape(.rect(cornerRadius: 15))
                        .overlay(alignment: .trailing) {
                            Image(systemName: "chevron.right")
                                .resizable()
                                .frame(width: 15, height: 30)
                                .foregroundStyle(Color(.label))
                                .padding(10)
                                
                        }
                        .overlay(alignment: .topLeading) {
                            Text("Current Location")
                                .foregroundStyle(Color(.label))
                                .font(.title3)
                                .padding(5)
                            
                        }.matchedTransitionSource(id: 1, in: namespace)
                    }
                        
                    // Appears in movies
                    VStack(alignment: .leading){
                        Text("Appears in:").font(.title2)
                        Spacer()
                        ForEach(predator.movies, id: \.self){ movie in
                            Text("• \(movie)")
                        }
                    }
                  
                    // Movie scenes
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Movie Moments").font(.title)
                  
                        ForEach(predator.movieScenes){ movieScene in
                            Spacer()
                            Text(movieScene.movie)
                                .font(.title3)
                                .fontWeight(.semibold)
                    
                            Text(movieScene.sceneDescription)
                        }
                    }

                    // Link
                    Link("About: \(predator.name)",
                         destination: URL(string: "\(predator.link)")!)
                    
                }.padding()
            }
        }
        .ignoresSafeArea()
        .preferredColorScheme(ColorScheme.dark)
    }
}

#Preview {
    let predatorFactory = PredatorFactory().allapexPredators[10]
    let position = PredatorFactory().allapexPredators[10].location
    
    NavigationStack {
        PredatorDetailView(
            predator: predatorFactory,
            mapCameraPosition:
                    .camera(
                        MapCamera(
                            centerCoordinate: position,
                            distance: 3000
                        )
                    )
        )
    }
}
