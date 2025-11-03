//
//  ContentView.swift
//  Apex Predators
//
//  Created by Samir Ramic on 25.10.25.
//

import SwiftUI

struct MainView: View {
    var predatorFactory = PredatorFactory()
    @State var searchText: String = ""
    @State var alphabeticalOrder: Bool = false
    
    //Computed property
    var filteredPredators: [ApexPredator] {
        predatorFactory.sort(by: alphabeticalOrder)
        return predatorFactory.search(for: searchText)
    }
    
    var body: some View {
        NavigationStack {
            List(filteredPredators) { predator in
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
            }
            .navigationTitle("Apex Predators")
            .searchable(
                text: $searchText,
                placement: .navigationBarDrawer(displayMode: .always)
            )
            .autocorrectionDisabled()
            .animation(.default, value: searchText)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        withAnimation {
                          alphabeticalOrder.toggle()
                        }
                    } label: {
                        Image(systemName: alphabeticalOrder ? "film" : "textformat")
                            .symbolEffect(.bounce, value: alphabeticalOrder)
                    }
                }
            }
            .preferredColorScheme(.dark)
        }
    }
}

#Preview {
    MainView()
}
