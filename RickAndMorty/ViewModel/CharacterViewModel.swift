//
//  CharacterViewModel.swift
//  RickAndMorty
//
//  Created by Balla Tamás on 2022. 10. 10..
//

import Foundation
import UIKit
import CoreData

class CharacterViewModel {
    
    private var api: RickAndMortyApi = RickAndMortyApi.instance
    private var database: DataController = DataController.instance
    
    public func getCharactersFromApi(completion: @escaping (Characters) -> ()) {
        api.fetch(endpoint: "characters") { data in
            completion(data)
        }
    }
    
    public func getSingleCharacterFromApi(withID id: Int, completion: @escaping (CharacterModel) -> ()) {
        api.getCharacter(id: id, completion: completion)
    }
    
    public func getImage(fromUrl url: String, completion: @escaping (UIImage) -> ()) {
        api.getImage(fromUrl: url, completion: completion)
    }
    
    public func getEpisodes(urls: [String], completion: @escaping ([EpisodeModel]) -> ()) {
        api.getEpisodes(urls: urls, completion: completion)
    }
    
    public func toggleFavourite(character: CharacterModel, isFavourite: Bool) {
        if(isFavourite) {
            database.saveCharacter(character: character)
            return
        }
        database.removeCharacter(id: character.id)
    }
    
    public func getFavourites() -> [CharacterModel]? {
        return database.getFavourites()
    }
    
    public func isFavourite(id: Int) -> Bool {
        return database.isFavourite(id: id)
    }
    
    public func removeCharacter(id: Int) {
        return database.removeCharacter(id: id)
    }
}
