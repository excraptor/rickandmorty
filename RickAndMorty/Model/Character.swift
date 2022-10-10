//
//  Character.swift
//  RickAndMorty
//
//  Created by Balla Tamás on 2022. 10. 10..
//

import Foundation

// MARK: - Character

struct Characters: Decodable {
    let info: String
    let data: [CharacterModel]
}

struct CharacterModel: Decodable {
    let displayName: String
    let status: String
    let origin: CharacterOrigin
    
    let species: String
    let image: String
    let episodes: [String]
}

struct CharacterOrigin: Decodable {
    let name: String
    let url: String
}
