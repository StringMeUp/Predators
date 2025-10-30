//
//  ContentView.swift
//  Apex Predators
//
//  Created by Samir Ramic on 25.10.25.
//

import SwiftUI

struct MainView: View {
    let predatorFactory = PredatorFactory()
    var body: some View {
        NavigationStack {
            List(predatorFactory.apexPredators){ predator in
                NavigationLink {
                    Image(predator.imageUrl)
                        .resizable()
                        .scaledToFit()
                } label: {
                    HStack {
                        Image(predator.imageUrl)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                            .shadow(color: .white, radius: 2)
                            .padding()
        
                        VStack(alignment: .leading) {
        
                            Text(predator.name)
                                .fontWeight(.bold)
        
                            Text(predator.type.rawValue)
                                .font(.subheadline)
                                .padding(.horizontal, 13)
                                .padding(.vertical, 5)
                                .background(predator.backgroundColor)
                                .clipShape(.capsule)
                                .padding(.vertical, 4)
        
                        }
                    }
                }
        
            }.navigationTitle("Apex Predators")
        
        } .preferredColorScheme(ColorScheme.dark)
    }
}

#Preview {
    MainView()
}
