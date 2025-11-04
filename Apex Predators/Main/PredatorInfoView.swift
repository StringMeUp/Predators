//
//  PredatorInfoView.swift
//  Apex Predators
//
//  Created by Samir Ramic on 30.10.25.
//

import SwiftUI

struct PredatorInfoView: View {
   
    var predator: ApexPredator
    
    var body: some View {
        // predator item
        HStack {
            // image
            Image(predator.imageUrl)
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .shadow(color: .white, radius: 2)
                .padding()
            
            VStack(alignment: .leading) {
                // name
                Text(predator.name)
                    .fontWeight(.bold)
                // type
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
}
