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
    
    var searchResults: [Pokemon] = []
    
    // MARK: - CRUD
    
    func createPokemonObject(fromSearchTerm searchTerm: String, completion: @escaping () -> Void) {
        fetchSearchResults(fromSearchTerm: searchTerm) { (success) in
            if success == true {
                print("Fetching ALL of the Pokemon was a big Success!")
                completion()
            } else {
                print("Could not Fetch at least one Pokemon")
                completion()
            }
        }
    }
    
    func createPokemon(onTeam pokemonTeam: PokemonTeam, fromPokemonObject pokemonObject: Pokemon) {
        var pokemonTeamRef: CKReference
        if pokemonObject.pokemonTeamRef == nil {
            guard let recordID = pokemonTeam.recordID else {return}
            pokemonObject.pokemonTeamRef = CKReference(recordID: recordID, action: .deleteSelf)
            guard let teamRef = pokemonObject.pokemonTeamRef else {return}
            pokemonTeamRef = teamRef
        } else {
            guard let teamRef = pokemonObject.pokemonTeamRef else {return}
            pokemonTeamRef = teamRef
        }
            let name = pokemonObject.name
            let moves = pokemonObject.moves
            let type1 = pokemonObject.type1
            let type2 = pokemonObject.type2
            let abilities = pokemonObject.abilities
            let imageEndpoint =  pokemonObject.imageEndpoint
            let hpStat = pokemonObject.hpStat
            let attackStat = pokemonObject.attackStat
            let defenseStat = pokemonObject.defenseStat
            let spAttackStat = pokemonObject.spAttackStat
            let spDefenseStat = pokemonObject.spDefenseStat
            let speedStat = pokemonObject.speedStat
            let pokemon = Pokemon(name: name, moves: moves, type1: type1, type2: type2, abilities: abilities, imageEndpoint: imageEndpoint, hpStat: hpStat, attackStat: attackStat, defenseStat: defenseStat, spAttackStat: spAttackStat, spDefenseStat: spDefenseStat, speedStat: speedStat)
            pokemonTeam.sixPokemon.append(pokemon)
            pokemon.pokemonTeamRef = pokemonTeamRef
        guard let record = pokemon.ckRecord else {return}
        PokemonController.shared.savePokemonRecord(record: record) { (success) in
            if success == true {
                print("Saving your Pokemon was a big Success!")
            } else {
                print("Saving your Pokemon Failed")
            }
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
    func fetchSearchResults(fromSearchTerm searchTerm: String, completion: @escaping (Bool) -> Void) {
        var finalURL: URL
        if typesKeyArray.contains(searchTerm) {
            guard let url = URL(string: Keys.baseURLString)?.appendingPathComponent(Keys.searchTypeKey).appendingPathComponent(searchTerm) else {
                completion(false)
                return
            }
            finalURL = url
            let dataTask = URLSession.shared.dataTask(with: finalURL){ (data, _, error) in
                if let error = error {
                    print("There was an error fetching Pokemon data: \(error.localizedDescription)")
                    completion(false)
                    return
                }
                guard let data = data else {
                    completion(false)
                    return
                }
                guard let jsonDictionary = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any],
                    let pokemonArray = jsonDictionary?[Keys.pokemonArrayKey] as? [[String: Any]] else {
                        completion(false)
                        return
                }
                for dictionary in pokemonArray {
                    guard let pokemonDictionary = dictionary[Keys.pokemonDictionaryKey] as? [String: Any],
                        let pokemonURLString = pokemonDictionary[Keys.pokemonURLKey] as? String,
                        let pokemonURL = URL(string: pokemonURLString) else {
                            completion(false)
                            return
                    }
                    self.fetchPokemon(withURL: pokemonURL, completion: { (success) in
                        completion(success)
                    })
                }
            }
            dataTask.resume()
        } else {
            guard let url = URL(string: Keys.baseURLString)?.appendingPathComponent(Keys.searchPokemonKey).appendingPathComponent(searchTerm) else {
                completion(false)
                return}
            finalURL = url
            fetchPokemon(withURL: finalURL, completion: { (success) in
                completion(success)
            })
        }
    }

    func fetchPokemon(withURL url: URL, completion: @escaping (Bool)->Void) {
        var searchResults: [Pokemon] = []
        let dataTask = URLSession.shared.dataTask(with: url){ (data, _, error) in
            if let error = error {
                print("There was an error fetching Pokemon data: \(error.localizedDescription)")
                completion(false)
                return
            }
            guard let data = data,
                let jsonDictionary = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String:Any],
                let dictionary = jsonDictionary,
                let pokemon = Pokemon(dictionary: dictionary),
                let imageURL = pokemon.imageURL else {
                    completion(false)
                    return
                }
            self.fetchImageData(withURL: imageURL, completion: { (data) in
                guard let data = data else {
                    completion(false)
                    return
                }
                pokemon.imageData = data
                searchResults.append(pokemon)
                PokemonController.shared.searchResults = searchResults
                completion(true)
            })
        }
        dataTask.resume()
    }


    func fetchImageData(withURL url:URL, completion: @escaping (Data?)-> Void) {
        let dataTask = URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                print("There was an error with the fetch image dataTask: \(error.localizedDescription)")
                completion(nil)
            }
            completion(data)
        }
        dataTask.resume()
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














