//
//  CharacterViewModel.swift
//  RickAndMorty
//
//  Created by Balla Tamás on 2022. 10. 10..
//

import Foundation

class CharacterViewModel {
    
    private var api: API = RickAndMortyApi.instance
    
    public func getCharactersFromApi(completion: @escaping (Characters) -> ()) {
        api.fetch(endpoint: "characters") { data in
            completion(data)
        }
    }
}
