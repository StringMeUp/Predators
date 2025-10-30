//
//  Predator.swift
//  Apex Predators
//
//  Created by Samir Ramic on 28.10.25.
//

import Foundation

class PredatorFactory {
    
    var apexPredators: [ApexPredator] = []
    
    init() {
        print("Init")
        decodePredatorsFromFile()
    }
    
    func decodePredatorsFromFile() {
        if let url = Bundle.main.url(forResource: "apexpredators", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                apexPredators = try decoder.decode([ApexPredator].self, from: data)
                print("Successfully parsed JSON data.\(apexPredators)")
            } catch {
                print("Error:\(error)")
            }
        }
    }
}
