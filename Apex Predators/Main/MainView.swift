//
//  ContentView.swift
//  Apex Predators
//
//  Created by Samir Ramic on 25.10.25.
//

import SwiftUI
import MapKit

struct MainView: View {
    @StateObject private var factory = PredatorFactory()
    @State var searchText: String = ""
    @State var alphabeticalOrder: Bool = false
    @State var currentTypeSelection: PredatorType = .all
    @State var currentMovieSelection: Movie = .all
    @State var selectedPredator: ApexPredator? = nil
    
    var body: some View {
        NavigationStack {
            List(factory.apexPredators) { predator in
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
                            selection: $currentTypeSelection.animation()
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
                
                ToolbarItem(placement: .topBarTrailing){
                    Menu {
                        Picker(
                            "Sort by movie",
                            selection: $currentMovieSelection.animation()
                        ) {
                        
                            ForEach(Movie.allCases){ movie in
                                Label(
                                    movie.rawValue.capitalized,
                                    systemImage: movie.icon
                                )
                            }
                        }
                    } label: {
                        Image(systemName: "film")
                    }
                    
                }
            }
            .preferredColorScheme(.dark)
            .onChange(of: selectedPredator) { oldValue, newValue in
                guard let predator = newValue else { return }
                factory.remove(predator: predator)
            }
            .onChange(of: searchText) { oldQuery, newQuery in
                factory.searchAndFilterPredators(with: newQuery, by: currentTypeSelection, by: currentMovieSelection)
            }
            .onChange(of: currentTypeSelection) { oldType, newType in
                factory.searchAndFilterPredators(with: searchText, by: newType, by: currentMovieSelection)
            }
            .onChange(of: currentMovieSelection) { oldMovie, newMovie in
                factory.searchAndFilterPredators(with: searchText, by: currentTypeSelection, by: newMovie)
            }
            .onChange(of: alphabeticalOrder) { oldOrder, newOrder in
                factory.sort(by: newOrder)
            }
        }
    }
}

#Preview {
    MainView()
}
