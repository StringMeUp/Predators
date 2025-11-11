//
//  ApexPredator.swift
//  Apex Predators
//
//  Created by Samir Ramic on 25.10.25.
//

import Foundation
import SwiftUI
import MapKit

struct ApexPredator: Decodable, Identifiable, Equatable {
    let id: Int
    let name: String
    let type: PredatorType
    let latitude: Double
    let longitude: Double
    let movies: [Movie]
    let movieScenes: [MovieScene]
    let link: String
    
    var imageUrl: String {
        return self.name.lowercased().replacingOccurrences(of: " ", with: "")
    }
    
    var location: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    var backgroundColor: Color {
        switch self.type {
        case .land:
            return Color.brown
        case .air:
            return Color.teal
        case .sea:
            return Color.blue
        case .all:
            return Color.black
        }
    }
}
