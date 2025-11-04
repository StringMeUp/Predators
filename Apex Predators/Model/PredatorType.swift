//
//  PredatorType.swift
//  Apex Predators
//
//  Created by Samir Ramic on 28.10.25.
//

enum PredatorType: String, Decodable, CaseIterable, Identifiable {
    
    var id: PredatorType { self }
    case all
    case land
    case air
    case sea
    
    var icon: String {
        switch self {
        case .all: "checkmark.circle.fill"
        case .land: "leaf.fill"
        case .air: "airplane.up.forward"
        case .sea: "water.waves"
        }
    }
}
