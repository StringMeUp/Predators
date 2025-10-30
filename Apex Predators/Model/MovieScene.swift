//
//  MovieScene.swift
//  Apex Predators
//
//  Created by Samir Ramic on 25.10.25.
//

struct MovieScene: Decodable, Identifiable {
    let id: Int
    let movie: String
    let sceneDescription: String
}
