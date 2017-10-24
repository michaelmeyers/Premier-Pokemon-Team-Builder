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
    
    func updatePokemon(pokemon: Pokemon) {
        updatePokemonRecord(newPokemon: pokemon) { (success) in
            if success == true {
                print("Updating your Pokemon was a big Success!")
            } else {
                print("Updating Pokemon Failed")
            }
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
    
    func deletePokemon(pokemon: Pokemon) {
        guard let recordID = pokemon.recordID else {return}
        deletePokemonRecord(withID: recordID) { (_, error) in
            if let error = error {
                print("Error deleting Pokemon: \(error.localizedDescription)")
                return
            }
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
        
    func fetchPokemonRecordFor(pokemonTeam: PokemonTeam, withRecordType type: String, completion: @escaping ([CKRecord]?, Error?) -> Void) {
        
        let reference = CKReference(recordID: pokemonTeam.recordID!, action: .deleteSelf)
        let predicate = NSPredicate(format: "%K == %@", Keys.ckReferenceKey,  reference)
        let query = CKQuery(recordType: Keys.ckPokemonRecordType, predicate: predicate)
        privateDatabase.perform(query, inZoneWith: nil, completionHandler: completion)
    }
    
    func savePokemonRecord(record: CKRecord, completion: @escaping (Bool) -> Void) {
        privateDatabase.save(record) { (_, error) in
            var success: Bool = true
            if let error = error {
                print("There was an error saving Pokemon Team: \(error.localizedDescription)")
                success = false
                completion(success)
                return
            }
            print("No Error")
            completion(success)
        }
    }
    
    func updatePokemonRecord(newPokemon: Pokemon, completion: @escaping (Bool) -> Void) {
        var success: Bool = true
        guard let record = newPokemon.ckRecord else {
            success = false
            completion(success)
            return
        }
        savePokemonRecord(record: record) { (success) in
            completion(success)
        }
    }
    
    func deletePokemonRecord(withID recordID: CKRecordID, completion: @escaping (CKRecordID?, Error?) -> Void) {
        privateDatabase.delete(withRecordID: recordID, completionHandler: completion)
    }
    
}














