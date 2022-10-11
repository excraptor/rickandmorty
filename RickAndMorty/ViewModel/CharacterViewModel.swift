//
//  CharacterViewModel.swift
//  RickAndMorty
//
//  Created by Balla Tamás on 2022. 10. 10..
//

import Foundation
import UIKit

class CharacterViewModel {
    
    private var api: RickAndMortyApi = RickAndMortyApi.instance
    
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
    
    public func getEpisodes(urls: [String], completion: @escaping ([CharacterEpisode]) -> ()) {
        api.getEpisodes(urls: urls, completion: completion)
    }
}
