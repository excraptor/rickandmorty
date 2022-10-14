//
//  Character.swift
//  RickAndMorty
//
//  Created by Balla Tamás on 2022. 10. 10..
//

import Foundation
import UIKit

// MARK: - Character

struct Characters: Codable {
    let info: CharacterInfo
    let results: [CharacterModel]
}

struct CharacterModel: Codable {
    let id: Int
    let name: String
    let status: String?
    let species: String?
    let type: String?
    let gender: String?
    let origin: CharacterOrigin?
    let location: CharacterLocation?
    let image: String?
    let episode: [String]?
    let url: String?
    let created: String?
    
    init(id: Int, name: String) {
        self.id = id
        self.name = name
        self.status = nil
        self.species = nil
        self.type = nil
        self.gender = nil
        self.origin = nil
        self.location = nil
        self.image = nil
        self.episode = nil
        self.url = nil
        self.created = nil
    }
    
    init(id: Int,
         name: String,
         status: String,
         species: String,
         type: String,
         gender: String,
         origin: CharacterOrigin,
         location: CharacterLocation,
         image: String,
         episode: [String],
         url: String,
         created: String) {
        self.id = id
        self.name = name
        self.status = status
        self.species = species
        self.type = type
        self.gender = gender
        self.origin = origin
        self.location = location
        self.image = image
        self.episode = episode
        self.url = url
        self.created = created
    }
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

struct CharacterDetailData {
    let name: String
    let status: String
    let species: String
    let origin: CharacterOrigin
    let imageURL: String
}

struct EpisodeModel: Codable {
    let id: Int
    let name: String
    let airDate: String
    let episode: String
    let characters: [String]
    let url: String
    let created: String
}
