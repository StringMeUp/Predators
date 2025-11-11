//
//  Movie.swift
//  Apex Predators
//
//  Created by Samir Ramic on 28.10.25.
//

enum Movie : String, Decodable, CaseIterable, Identifiable {
    
    var id: Movie { self }
    case all = "All"
    case jurassicPark = "Jurassic Park"
    case theLostWorld = "The Lost World: Jurassic Park"
    case jurassicParkIII = "Jurassic Park III"
    case jurassicWorld = "Jurassic World"
    case fallenKingdom = "Jurassic World: Fallen Kingdom"
    case dominion = "Jurassic World: Dominion"
    
    var icon: String { "film" }
}
