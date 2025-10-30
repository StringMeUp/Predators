//
//  ApexPredator.swift
//  Apex Predators
//
//  Created by Samir Ramic on 25.10.25.
//

import Foundation
import SwiftUI

struct ApexPredator: Decodable, Identifiable {
    let id: Int
    let name: String
    let type: PredatorType
    let latitude: Double
    let longitude: Double
    let movies: [String]
    let movieScenes: [MovieScene]
    let link: String
    
    var imageUrl: String {
        return self.name.lowercased().replacingOccurrences(of: " ", with: "")
    }
    
    var backgroundColor: Color {
        switch self.type {
        case .land:
            return Color.brown
        case .air:
            return Color.teal
        case .sea:
            return Color.blue
        }
    }
}
