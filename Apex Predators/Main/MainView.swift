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
    @State var currentSelection: PredatorType = .all
    
    //Computed property
    var filteredPredators: [ApexPredator] {
        predatorFactory.filter(by: currentSelection)
        predatorFactory.sort(by: alphabeticalOrder)
        return predatorFactory.search(for: searchText)
    }
    
    var body: some View {
        NavigationStack {
            List(filteredPredators) { predator in
                NavigationLink {
                    // detail info
                    PredatorDetailView(predator: predator)
                } label: {
                    PredatorInfoView(predator: predator)
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
                // order alphabetically
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
                
                // popup menu filter
                ToolbarItem(placement: .topBarTrailing){
                    Menu {
                        Picker("Sort by", selection: $currentSelection.animation()) {
                           ForEach(PredatorType.allCases){ type in
                               Label(type.rawValue.capitalized, systemImage: type.icon)
                           }
                        }
                    } label: {
                        Image(systemName: "slider.horizontal.3")
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
