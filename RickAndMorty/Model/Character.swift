//
//  Character.swift
//  RickAndMorty
//
//  Created by Balla Tamás on 2022. 10. 10..
//

import Foundation

// MARK: - Character

struct Characters: Codable {
    let info: CharacterInfo
    let results: [CharacterModel]
}

struct CharacterModel: Codable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let type: String
    let gender: String
    let origin: CharacterOrigin
    let location: CharacterLocation
    let image: String
    let episode: [String]
    let url: String
    let created: String
}

struct CharacterInfo: Codable {
    let count: Int
    let pages: Int
    let next: String
    let prev: String?
}

struct CharacterOrigin: Codable {
    let name: String
    let url: String
}

struct CharacterLocation: Codable {
    let name: String
    let url: String
}

struct CharacterListData {
    let name: String
    let status: String
    let origin: CharacterOrigin
}
