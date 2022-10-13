//
//  EpisodeViewModel.swift
//  RickAndMorty
//
//  Created by Balla Tamás on 2022. 10. 11..
//

import Foundation

class EpisodeViewModel {
    private var api: RickAndMortyApi = RickAndMortyApi.instance
    
    public func getEpisodeDetails(id: Int, completion: @escaping (EpisodeModel) -> ()) {
        api.getEpisode(id: id, completion: completion)
    }
    
    public func getCharacters(fromUrls urls: [String], completion: @escaping ([CharacterModel]) -> ()) {
        api.getCharacters(fromUrls: urls, completion: completion)
    }
}
