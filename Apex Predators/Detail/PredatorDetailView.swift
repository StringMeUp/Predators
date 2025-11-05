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
    @State var mapCamera: MapCameraPosition = MapCameraPosition.automatic

    var body: some View {
       
        GeometryReader{ geo in
            ScrollView {
                ZStack(alignment: Alignment.bottomTrailing) {
                    // Background Image
                    Image(predator.type.rawValue)
                        .resizable()
                        .scaledToFit()
                
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
                    ZStack(alignment: .trailing){
                        Map(position: $mapCamera){
                            Marker(
                                coordinate: CLLocationCoordinate2D(
                                    latitude: predator.latitude,
                                    longitude: predator.longitude
                                ),
                                label: {
                                    Image(predator.imageUrl)
                                })
                        }
                        NavigationLink{
                            Image(predator.imageUrl)
                        } label: {
                            Image(systemName: "chevron.right")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 20, height: 20)
                                .foregroundColor(Color.white)
                                .padding()
                        }
                        
                    }.frame(width: .none, height: 150).cornerRadius(20)
                   
                    // Appears in movies
                    VStack(alignment: .leading){
                        Text("Appears in:").font(.title2)
                        Spacer()
                        ForEach(predator.movies, id: \.self){ movie in
                            Text("\u{2022} \(movie)")
                        }
                    }
                  
                    // Movie scenes
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Movie Moments").font(.title)
                  
                        ForEach(predator.movieScenes){ movieScene in
                            Spacer()
                            Text(movieScene.movie)       .font(.title3)
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
    let predatorFactory = PredatorFactory().allapexPredators[1]
    PredatorDetailView(predator: predatorFactory)
}
