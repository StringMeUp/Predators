//
//  ContentView.swift
//  Apex Predators
//
//  Created by Samir Ramic on 25.10.25.
//

import SwiftUI
import MapKit

struct MainView: View {
    var predatorFactory = PredatorFactory()
    @State var searchText: String = ""
    @State var alphabeticalOrder: Bool = false
    @State var currentSelection: PredatorType = .all
    @State var selectedPredator: ApexPredator? = nil
    @State var predators: [ApexPredator] = []
    
    //Computed property
    var filteredPredators: [ApexPredator] {
        predatorFactory.filter(by: currentSelection)
        predatorFactory.sort(by: alphabeticalOrder)
        return predatorFactory.search(for: searchText)
    }
    
    var body: some View {
        NavigationStack {
            List(predators) { predator in
                NavigationLink {
                    // detail info
                    PredatorDetailView(
                        predator: predator,
                        mapCameraPosition: .camera(MapCamera(centerCoordinate: predator.location, distance: 30000)))
                } label: {
                    PredatorInfoView(predator: predator){
                        selectedPredator = predator
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
                // order alphabetically
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        withAnimation {
                            alphabeticalOrder.toggle()
                        }
                    } label: {
                        Image(
                            systemName: alphabeticalOrder ? "film" : "textformat"
                        )
                        .symbolEffect(.bounce, value: alphabeticalOrder)
                    }
                }
                
                // popup menu filter
                ToolbarItem(placement: .topBarTrailing){
                    Menu {
                        Picker(
                            "Sort by",
                            selection: $currentSelection.animation()
                        ) {
                            ForEach(PredatorType.allCases){ type in
                                Label(
                                    type.rawValue.capitalized,
                                    systemImage: type.icon
                                )
                            }
                        }
                    } label: {
                        Image(systemName: "slider.horizontal.3")
                    }
                }
            }
            .preferredColorScheme(.dark)
        }
        .onChange(of: selectedPredator) { oldValue, newValue in
            guard let predator = newValue else { return }
            predators = predatorFactory.remove(predator: predator)
        }
        .onChange(of: filteredPredators) { _, _ in
           predators = filteredPredators
        }
        .onAppear {
            predators = filteredPredators
        }
    }
}

#Preview {
    MainView()
}
