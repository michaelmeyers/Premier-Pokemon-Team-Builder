//
//  NetworkController.swift
//  PremierTeamBuilder
//
//  Created by Michael Meyers on 10/23/17.
//  Copyright © 2017 Michael Meyers. All rights reserved.
//

import Foundation

class NetworkController {
    
    func fetchPokemonData(fromSearchTerm searchTerm: String, completion: @escaping (Data?) -> Void) {
        var finalURL: URL
        if typesKeyArray.contains(searchTerm) {
            guard let url = URL(string: Keys.baseURLString)?.appendingPathComponent(Keys.searchTypeKey).appendingPathComponent(searchTerm) else {
                    completion(nil)
                    return}
            finalURL = url
        } else {
            guard let url = URL(string: Keys.baseURLString)?.appendingPathComponent(Keys.searchPokemonKey).appendingPathComponent(searchTerm) else {
                    completion(nil)
                    return}
            finalURL = url
        }
        let dataTask = URLSession.shared.dataTask(with: finalURL){ (data, _, error) in
            if let error = error {
                print("There was an error fetching Pokemon data: \(error.localizedDescription)")
                completion(nil)
                return
            }
            completion(data)
        }
        dataTask.resume()
    }
    
    func fetchMoveData(fromSearchTerm searchTerm: String, completion: @escaping (Data?) -> Void) {
        guard let moveURL = URL(string: Keys.baseURLString)?.appendingPathComponent(Keys.moveKey).appendingPathComponent(searchTerm) else {return}
        let dataTask = URLSession.shared.dataTask(with: moveURL) { (data,_, error) in
            if let error = error {
                print("There was an error with the move fetch: \(error.localizedDescription)")
                completion(nil)
                return
            }
            completion(data)
        }
        dataTask.resume()
    }
    
    func fetchImageData(withURL url:URL, completion: @escaping (Data?)-> Void) {
        
        let dataTask = URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                print("There was an error with the fetch image dataTask: \(error.localizedDescription)")
                return completion(nil)
            }
            completion(data)
        }
        dataTask.resume()
    }
    
    func fetchItemData() {
        
    }
}
