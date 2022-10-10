//
//  CharacterViewModel.swift
//  RickAndMorty
//
//  Created by Balla Tamás on 2022. 10. 10..
//

import Foundation

class CharacterViewModel {
    
    private var api: API = RickAndMortyApi.instance
    
    func getCharactersFromApi() {
        api.fetch(url: "asd.com")
    }
}
