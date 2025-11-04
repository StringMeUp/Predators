//
//  PredatorDetailView.swift
//  Apex Predators
//
//  Created by Samir Ramic on 25.10.25.
//

import SwiftUI

struct PredatorDetailView: View {
    
    var predator: ApexPredator

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
            
                // Name
            
                // Location
            
                // Appears in
            
                // Movie scenes
            
                // Link
            }
          
        }
        .ignoresSafeArea()
        .preferredColorScheme(ColorScheme.dark)
    }
}

#Preview {
    let predatorFactory = PredatorFactory().allapexPredators.first!
    PredatorDetailView(predator: predatorFactory)
}
