//
//  Predator.swift
//  Apex Predators
//
//  Created by Samir Ramic on 28.10.25.
//

import Foundation
import SwiftUI
internal import Combine

class PredatorFactory: ObservableObject {
    
    var allapexPredators: [ApexPredator] = []
    @Published var apexPredators: [ApexPredator] = []
    
    init() {
        decodePredatorsFromFile()
    }
    
    func decodePredatorsFromFile() {
        if let url = Bundle.main.url(
            forResource: "apexpredators",
            withExtension: "json"
        ) {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                allapexPredators = try decoder
                    .decode([ApexPredator].self, from: data)
                apexPredators = allapexPredators
                print("Successfully parsed JSON data.\(apexPredators)")
            } catch {
                print("Error:\(error)")
            }
        }
    }
    
    func search(for searchText: String) {
        if searchText.isEmpty {
            apexPredators = allapexPredators
        } else {
            apexPredators = allapexPredators.filter { predator in
                predator.name.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
    
    func sort(by alphabetical: Bool){
        if alphabetical {
            apexPredators.sort { $0.name < $1.name }
        }else{
            apexPredators.sort { $0.id < $1.id }
        }
    }
    
    func filter(by type: PredatorType, by movie: Movie) {
        if type == .all && movie == .all {
            apexPredators = allapexPredators
        } else {
            apexPredators = allapexPredators.filter { $0.type == type || $0.movies.contains(movie) }
        }
    }

    
    func remove(predator: ApexPredator) {
        apexPredators = apexPredators.filter { $0.id != predator.id }
        allapexPredators = allapexPredators.filter { $0.id != predator.id }
    }
    
    func searchAndFilterPredators(
        with searchText: String,
        by type: PredatorType,
        by movie: Movie
    ) {
        apexPredators = allapexPredators.filter { predator in
            // if empty -> all else search
            let matchesSearch = searchText.isEmpty || predator.name.localizedCaseInsensitiveContains(searchText)
            // if type all -> full list else only with type
            let matchesType = type == .all || predator.type == type
            // same
            let matchesMovie = movie == .all || predator.movies.contains(movie)
            // all together
            return matchesSearch && matchesType && matchesMovie
        }
    }
}
