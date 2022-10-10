//
//  RickAndMortyApi.swift
//  RickAndMorty
//
//  Created by Balla Tamás on 2022. 10. 10..
//

import Foundation

protocol API {
    func fetch(endpoint: String, completion: @escaping (Characters) -> ())
}

class RickAndMortyApi: API {
    
    private let baseURL: URL = URL(string: "https://rickandmortyapi.com/api")!
    
    public static let instance = RickAndMortyApi()
    
    private init() { }
    
    func fetch(endpoint: String, completion: @escaping (Characters) -> ()) {
        print("### fetching \(endpoint)")
        getCharacter { data in
            completion(data)
        }
    }
    
    public func getCharacter(detail: Int? = nil, completion: @escaping (Characters) -> ()) {
        var url = baseURL.appendingPathComponent("/character")
        if let detail = detail {
            url = url.appendingPathComponent("/\(detail)")
        }
        
        let dataTask = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else { return }
            do {
                let characterData = try JSONDecoder().decode(Characters.self, from: data)
                
                completion(characterData)
            } catch {
                print("Api call went wrong")
            }
        }
        
        dataTask.resume()
    }
    
}
