//
//  RickAndMortyApi.swift
//  RickAndMorty
//
//  Created by Balla Tamás on 2022. 10. 10..
//

import Foundation

protocol API {
    func fetch(url: String)
}

class RickAndMortyApi: API {
    
    private let baseURL: URL = URL(string: "https://rickandmortyapi.com/api")!
    
    public static let instance = RickAndMortyApi()
    
    private init() { }
    
    func fetch(url: String) {
        print("fetching \(url)")
    }
    
    func getCharacters(completion: @escaping (Characters) -> ()) {
        let dataTask = URLSession.shared.dataTask(with: self.baseURL.appendingPathComponent("/character")) { data, _, error in
            guard let data = data, error == nil else { return }
            do {
                let characterData = try JSONDecoder().decode(Characters.self, from: data)
                
                completion(characterData)
            } catch {
                print("Something went wrong")
            }
        }
        
        dataTask.resume()
    }
}
