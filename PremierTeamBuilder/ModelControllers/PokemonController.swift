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
    var pokemonTypeDictionary: [String: [Pokemon]] = [:]
    
    // MARK: - CRUD
    func createPokemonObject(fromSearchTerm searchTerm: String, completion: @escaping () -> Void) {
        searchResults = []
        switch searchTerm {
        case Keys.typeNormalKey: fillSearchResults(withKey: Keys.typeNormalKey, orSearchTerm: searchTerm, completion: completion)
        case Keys.typeFireKey: fillSearchResults(withKey: Keys.typeFireKey, orSearchTerm: searchTerm, completion: completion)
        case Keys.typeWaterKey: fillSearchResults(withKey: Keys.typeWaterKey, orSearchTerm: searchTerm, completion: completion)
        case Keys.typeElectricKey: fillSearchResults(withKey: Keys.typeElectricKey, orSearchTerm: searchTerm, completion: completion)
        case Keys.typeGrassKey: fillSearchResults(withKey: Keys.typeGrassKey, orSearchTerm: searchTerm, completion: completion)
        case Keys.typeIceKey: fillSearchResults(withKey: Keys.typeIceKey, orSearchTerm: searchTerm, completion: completion)
        case Keys.typeFightingKey: fillSearchResults(withKey: Keys.typeFightingKey, orSearchTerm: searchTerm, completion: completion)
        case Keys.typePoisonKey: fillSearchResults(withKey: Keys.typePoisonKey, orSearchTerm: searchTerm, completion: completion)
        case Keys.typeGroundKey: fillSearchResults(withKey: Keys.typeGroundKey, orSearchTerm: searchTerm, completion: completion)
        case Keys.typeFlyingKey: fillSearchResults(withKey: Keys.typeFlyingKey, orSearchTerm: searchTerm, completion: completion)
        case Keys.typePsychicKey: fillSearchResults(withKey: Keys.typePsychicKey, orSearchTerm: searchTerm, completion: completion)
        case Keys.typeBugKey: fillSearchResults(withKey: Keys.typeBugKey, orSearchTerm: searchTerm, completion: completion)
        case Keys.typeRockKey: fillSearchResults(withKey: Keys.typeRockKey, orSearchTerm: searchTerm, completion: completion)
        case Keys.typeGhostKey: fillSearchResults(withKey: Keys.typeGhostKey, orSearchTerm: searchTerm, completion: completion)
        case Keys.typeDragonKey: fillSearchResults(withKey: Keys.typeDragonKey, orSearchTerm: searchTerm, completion: completion)
        case Keys.typeDarkKey: fillSearchResults(withKey: Keys.typeDarkKey, orSearchTerm: searchTerm, completion: completion)
        case Keys.typeSteelKey: fillSearchResults(withKey: Keys.typeSteelKey, orSearchTerm: searchTerm, completion: completion)
        case Keys.typeFairyKey: fillSearchResults(withKey: Keys.typeFairyKey, orSearchTerm: searchTerm, completion: completion)
        default:
            PokemonController.shared.fetchPokemonSearchResults(fromSearchTerm: searchTerm, completion: { (success) in
                if success == true {
                    print("Successfully Fetched Pokemon")
                    completion()
                } else {
                    print("Somethings Wrong with the individual Pokemon fetch")
                    completion()
                }
            })
        }
    }
    
    func fillSearchResults(withKey dictionaryKey: String, orSearchTerm searchTerm: String, completion: @escaping () -> Void) {
        if let Types = pokemonTypeDictionary[dictionaryKey] {
            searchResults = Types
            completion()
        } else {
            fetchPokemonTypeSearchResults(fromSearchTerm: searchTerm, storeInToDictionaryWithKey: dictionaryKey, completion: { (success) in
                if success == true {
                    print("Successfully Fetched All Pokemon for That Type")
                    completion()
                } else {
                    print("Issue fetching that type of pokemon")
                    completion()
                }
            })
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
        let moveIDs = pokemonObject.moveIDs
        let type1 = pokemonObject.type1
        let type2 = pokemonObject.type2
        let abilities = pokemonObject.abilities
        let hpStat = pokemonObject.hpStat
        let attackStat = pokemonObject.attackStat
        let defenseStat = pokemonObject.defenseStat
        let spAttackStat = pokemonObject.spAttackStat
        let spDefenseStat = pokemonObject.spDefenseStat
        let speedStat = pokemonObject.speedStat
        let imageEndpoint = pokemonObject.imageEndpoint
        
        let imageData = pokemonObject.imageData
        
        let pokemon = Pokemon(name: name, moveIDs: moveIDs, type1: type1, type2: type2, abilities: abilities, hpStat: hpStat, attackStat: attackStat, defenseStat: defenseStat, spAttackStat: spAttackStat, spDefenseStat: spDefenseStat, speedStat: speedStat, imageData: imageData, imageEndpoint: imageEndpoint)
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
    
    func loadPokemon(fromRecords records: [CKRecord]?, pokemonTeamRef: CKReference, completion: ([Pokemon]?) -> Void) {
        var pokemonArray: [Pokemon] = []
        guard let records = records else {
            print("No records from pokemon fetch")
            completion(nil)
            return}
        for record in records {
            guard let pokemon = Pokemon(ckRecord: record, pokemonTeamRef: pokemonTeamRef) else {
                completion(nil)
                return}
            pokemonArray.append(pokemon)
        }
        completion(pokemonArray)
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
    
    func deletePokemon(pokemon: Pokemon, fromTeam team: PokemonTeam) {
        guard let recordID = pokemon.recordID else {return}
        
        let pokemonArray = team.sixPokemon.flatMap({$0})
        
        
        
        guard let index = pokemonArray.index(of: pokemon) else { return }
        
        team.sixPokemon.remove(at: index)
        
        deletePokemonRecord(withID: recordID) { (_, error) in
            if let error = error {
                print("Error deleting Pokemon: \(error.localizedDescription)")
                return
            }
        }
    }
    
    // MARK: - API CALLS
    
    func fetchPokemonTypeSearchResults (fromSearchTerm searchTerm: String, storeInToDictionaryWithKey dictionaryKey: String, completion: @escaping (Bool) -> Void) {
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
                let group = DispatchGroup()
                for dictionary in pokemonArray {
                    group.enter()
                    guard let pokemonDictionary = dictionary[Keys.pokemonDictionaryKey] as? [String: Any],
                        let pokemonURLString = pokemonDictionary[Keys.pokemonURLKey] as? String,
                        let pokemonURL = URL(string: pokemonURLString) else {
                            completion(false)
                            return
                    }
                    self.fetchPokemon(withURL: pokemonURL, completion: { (success) in
                        group.leave()
                    })
                }
                group.notify(queue: .main, execute: {
                    PokemonController.shared.searchResults = PokemonController.shared.searchResults.sorted {$0.name < $1.name }
                    self.pokemonTypeDictionary[dictionaryKey] = PokemonController.shared.searchResults
                    completion(true)
                })
            }
            dataTask.resume()
        }
    }
    
    func fetchPokemonSearchResults (fromSearchTerm searchTerm: String, completion: @escaping (Bool) -> Void) {
        guard let url = PokemonTeamController.shared.pokemonList[searchTerm] else {return}
        let finalURL = url
        fetchPokemon(withURL: finalURL, completion: { (success) in
            completion(success)
        })
    }
    
    func fetchPokemon(withURL url: URL, completion: @escaping (Bool) -> Void) {
        let dataTask = URLSession.shared.dataTask(with: url){ (data, _, error) in
            if let error = error {
                print("There was an error fetching Pokemon data: \(error.localizedDescription)")
                completion(false)
                return
            }
            guard let data = data,
                let jsonDictionary = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String:Any],
                let dictionary = jsonDictionary,
                let pokemon = Pokemon(dictionary: dictionary) else {
                    completion(false)
                    return
            }
            if let imageURL = pokemon.imageURL {
                self.fetchImageData(withURL: imageURL, completion: { (data) in
                    if let data = data {
                        pokemon.imageData = data
                        PokemonController.shared.searchResults.append(pokemon)
                        completion(true)
                    }
                })
            } else {
                PokemonController.shared.searchResults.append(pokemon)
                print ("Pokemon added to search Results")
                completion(true)
            }
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
    
    func fetchPokemonRecordFor(pokemonTeam: PokemonTeam, withRecordType type: String, completion: @escaping ([CKRecord]?, CKReference, Error?) -> Void) {
        
        let reference = CKReference(recordID: pokemonTeam.recordID!, action: .deleteSelf)
        let predicate = NSPredicate(format: "%K == %@", Keys.ckReferenceKey,  reference)
        let query = CKQuery(recordType: Keys.ckPokemonRecordType, predicate: predicate)
        privateDatabase.perform(query, inZoneWith: nil) { (records, error) in
            completion(records, reference, error)
        }
    }
    
    func savePokemonRecord(record: CKRecord, completion: @escaping (Bool) -> Void) {
        privateDatabase.save(record) { (_, error) in
            var success: Bool = true
            if let error = error {
                print("There was an error saving Pokemon: \(error.localizedDescription)")
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
        let operation = CKModifyRecordsOperation(recordsToSave: [record], recordIDsToDelete: nil)
        operation.savePolicy = .changedKeys
        operation.queuePriority = .high
        operation.qualityOfService = .userInteractive
        privateDatabase.add(operation)
        completion(success)
    }
    
    func deletePokemonRecord(withID recordID: CKRecordID, completion: @escaping (CKRecordID?, Error?) -> Void) {
        privateDatabase.delete(withRecordID: recordID, completionHandler: completion)
    }
}














