//
//  Predator.swift
//  Apex Predators
//
//  Created by Samir Ramic on 28.10.25.
//

import Foundation
import SwiftUI
internal import Combine

class PredatorFactory {
    
   var allapexPredators: [ApexPredator] = []
   var apexPredators: [ApexPredator] = []
    
    init() {
        decodePredatorsFromFile()
    }
    
    func decodePredatorsFromFile() {
        if let url = Bundle.main.url(forResource: "apexpredators", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                allapexPredators = try decoder.decode([ApexPredator].self, from: data)
                apexPredators = allapexPredators
                print("Successfully parsed JSON data.\(apexPredators)")
            } catch {
                print("Error:\(error)")
            }
        }
    }
    
    func search(for seachText: String) -> [ApexPredator] {
        if seachText.isEmpty {
            return apexPredators
        } else {
            return apexPredators.filter{ predator in
                predator.name.localizedCaseInsensitiveContains(seachText)
            }
        }
    }
    
    func sort(by alphabetical: Bool){
        if alphabetical {
            apexPredators.sort{ $0.name < $1.name }
        }else{
            apexPredators.sort{ $0.id < $1.id }
        }
    }
    
    func filter(by type: PredatorType) {
        if type == .all {
             apexPredators = allapexPredators
        } else {
            apexPredators = allapexPredators.filter{ $0.type == type }
        }
    }
}
