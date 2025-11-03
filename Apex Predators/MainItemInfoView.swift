//
//  ApexMainItem.swift
//  Apex Predators
//
//  Created by Samir Ramic on 30.10.25.
//

import SwiftUI

struct MainItemInfoView: View {
   
    var predator: ApexPredator
    
    var body: some View {
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
}
