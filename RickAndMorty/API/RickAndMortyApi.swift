//
//  RickAndMortyApi.swift
//  RickAndMorty
//
//  Created by Balla Tamás on 2022. 10. 10..
//

import Foundation
import UIKit

protocol API {
    func fetch(endpoint: String, completion: @escaping (Characters) -> ())
}

class RickAndMortyApi: API {
    
    private let baseURL: URL = URL(string: "https://rickandmortyapi.com/api")!
    
    public static let instance = RickAndMortyApi()
    
    private init() { }
    
    func fetch(endpoint: String, completion: @escaping (Characters) -> ()) {
        print("### fetching \(endpoint)")
        getCharacters { data in
            completion(data)
        }
    }
    
    public func getCharacters(completion: @escaping (Characters) -> ()) {
        let url = baseURL.appendingPathComponent("/character")
        
        let dataTask = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else { return }
            do {
                let characterData = try JSONDecoder().decode(Characters.self, from: data)
                
                completion(characterData)
            } catch {
                print("Cannot retrieve characters from api")
            }
        }
        
        dataTask.resume()
    }
    
    public func getCharacter(id: Int, completion: @escaping (CharacterModel) -> ()) {
        let url = baseURL.appendingPathComponent("/character").appendingPathComponent("/\(id)")
        
        let dataTask = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else { return }
            do {
                let characterData = try JSONDecoder().decode(CharacterModel.self, from: data)
                
                completion(characterData)
            } catch {
                print("Cannot retrieve character \(id) from api")
            }
        }
        
        dataTask.resume()
    }
    
    public func getImage(fromUrl url: String, completion: @escaping (UIImage) -> ()) {
        let dataTask = URLSession.shared.dataTask(with: URL(string: url)!) { data, _, error in
            guard let data = data, error == nil else { return }
            if let imageData = data as Data? {
                completion(UIImage(data: imageData) ?? UIImage())
            }
        }
        
        dataTask.resume()
    }
    
}
