//
//  PokemonController.swift
//  PremierTeamBuilder
//
//  Created by Michael Meyers on 10/21/17.
//  Copyright © 2017 Michael Meyers. All rights reserved.
//

import Foundation
import UIKit
import CloudKit

class PokemonController {

    static let shared = PokemonController()
    
    // MARK: - CRUD
    func createPokemon(onTeam pokemonTeam: PokemonTeam, fromSearchTerm searchTerm: String){
        fetchPokemonData(fromSearchTerm: searchTerm) { (data) in
            guard let recordID = pokemonTeam.recordID else {return}
            let pokemonTeamRef = CKReference(recordID: recordID, action: .deleteSelf)
            guard let data = data,
            let jsonDictionary = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String:Any],
                let dictionary = jsonDictionary,
                let pokemon = Pokemon(dictionary: dictionary, pokemonTeamRef: pokemonTeamRef),
                let url = pokemon.imageURL else {return}
            self.getPokemonImageData(withURL: url, completion: { (data) in
                pokemon.imageData = data
            })
            pokemonTeam.sixPokemon?.append(pokemon)
        }
    }
    
    func getPokemonImageData(withURL url: URL, completion: @escaping (Data?) -> Void){
        fetchImageData(withURL: url) { (data) in
            guard let data = data else {
                completion(nil)
                return
            }
            completion(data)
        }
        
    }
    
    // MARK: - API CALLS
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
    
    // MARK: - Cloud Kit Functions
        
    let privateDatabase = CKContainer.default().privateCloudDatabase
        
    func fetchCKRecord(withType type: String) -> [CKRecord] {
            let records: [CKRecord] = []
            
            return records
    }
        
    func saveCKRecord() {
            
    }
}














